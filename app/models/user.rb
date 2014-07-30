class User < ActiveRecord::Base
  include PGArrayMethods
  include RedArrayMethods
  self.synchronous_commit(false)

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  mount_uploader :avatar, PhotoUploader
  mount_uploader :backdrop, BackdropUploader

  validates :username, presence: true, uniqueness: true,
            format: {with: /\A[A-Za-z0-9]+(?:[._-][A-Za-z0-9]+)*\z/i}, length: {minimum: 3, maximum: 20}
  validates :fullname, format: {with: /\A[a-z ,.'-]+\z/i}, length: {minimum: 3, maximum: 32}, allow_nil: true
  validates :gender, inclusion: {in: %w( MALE FEMALE )}, allow_nil: true
  validate  :verify_email_not_banned
  before_save  :squeeze_fullname
  after_create :create_settings_and_relations

##### Relations

  def posts
    self.relate_with_array(:owned_post_ids, Post)
  end

  def followers
    self.relate_with_array(:follower_ids, User)
  end

  def followed
    self.relate_with_array(:followed_ids, User)
  end

  def groups
    self.relate_with_array(:owned_group_ids, Group)
  end

  def conversations
    self.relate_with_array(:in_conversation_ids, Conversation)
  end

  def received_messages(conversation)
    Message.find(conversation.message_ids)
  end

  def settings
    set = Setting.find(self.id)
    return set unless set.nil?
    newset = Setting.create(user_id: self.id)
    return newset
  end

###

  def followed_ids
    # self.relations.pluck(:followed_ids)
  end

  def blocked_user_ids
    self.redget(:blocked_user_ids)
  end

  def flagger_ids
    self.get(:flagger_ids) #blech
  end
  
  def follower_count
    self.follower_ids.count
  end

  def followed_count
    self.followed_ids.count
  end

  def relations
    relate = UserRelation.find(self.id)
    return relate unless relate.nil?
    newrelate = UserRelation.create(user_id: self.id)
    return newrelate
  end

  def self.relation_types
    (self.to_s + "Relation").constantize
  end

##### Actions

  def follow!(user)
    User.transaction do
      self.append(:followed_ids, user.id)
      user.append(:follower_ids, self.id)
    end
  end

  def unfollow!(user)
    User.transaction do
      self.remove(:followed_ids, user.id)
      user.remove(:follower_ids, self.id)
    end
  end

  def like!(poly)
    poly.redappend(:liker_ids, self.id)
  end

  def unlike!(poly)
    poly.redremove(:liker_ids, self.id)
  end

  def create_post!(attrs={})
    attrs[:user_id] = self.id
    post = Post.create!(attrs)
    self.append(:owned_post_ids, post.id)
    return post
  end

  def share_post!(shared, attrs={})
    post = self.create_post!(attrs)
    shared.redappend(:shared_by_ids, post.id)
    return post
  end


  def create_comment!(poly, attrs={})
    attrs[:user_id] = self.id
    attrs[:threadable] = poly
    comment = Comment.create!(attrs)
    poly.redappend(:comment_ids, comment.id)
    return comment
  end

  def create_group!(users=[], attrs={})
    attrs[:user_id] = self.id
    attrs[:group_user_ids] = users.map(&:id).uniq
    group = Group.create!(attrs)
    self.append(:owned_group_ids, group.id)
    return group
  end

  def create_conversation_and_message!(users=[], mess_attrs={})
    mess_attrs[:user_id] = self.id
    users = (users << self).uniq
    conv_attrs = {started_by_entity: self.entity, owner_id: self.id, conversation_user_ids: users.map(&:id)}
    conv = Conversation.create!(conv_attrs)
    mess_attrs[:conversation_id] = conv.id
    mess = Message.create!(mess_attrs)
    self.append(:in_conversation_ids, conv.id)
    users.map{|u| u.append(:in_conversation_ids, conv.id)}
    conv.append(:message_ids, mess.id)
    return mess
  end

  def send_message!(conversation, mess_attrs={})
    mess_attrs[:user_id] = self.id
    mess_attrs[:conversation_id] = conversation.id
    mess = Message.create(mess_attrs)
    conversation.append(:message_ids, mess.id)
    return mess
  end

###

  def name
    return self.fullname if fullname.present?
    return self.username
  end

  def post_feed1
    Post.where(user_id: self.followed_ids).limit(10)
  end
  
  # these feeds are nonworking due to lack of geolocation function.

  def post_feed2(limit=10)
    Post.find_by_sql("SELECT * FROM posts WHERE user_id 
                      IN 
                     (SELECT unnest(followed_ids) FROM user_relations WHERE id = #{self.id})
                      LIMIT #{limit}")
  end

###

  def flag!(poly)
    poly.append(:flagger_ids, self.id)
  end

  def ban!
      puts "Are you sure you want to ban #{self.email}? [Y/n]"
      answer = gets.chomp
    if answer == "Y" || answer == "y"
      puts "Enter the ban report."      
      reason = gets.chomp
      self.update(deactivated: true)
      Ban.create(email: self.email, ban_report: reason)
      puts "#{self.email} is now banned!"
    else
      puts "#{self.email} not banned. Exiting function."
    end
  end

  def block_user!(user)
    self.redappend(:blocked_user_ids, user.id)
  end

  def banned?(email)
    Ban.find_by(email: email).present?
  end

  def send_feedback!(attrs={})
    Feedback.create(user_id: self.id, subject: attrs[:subject], body: attrs[:body])
  end


private

  def squeeze_fullname
    if self.fullname.blank?
      self.fullname = nil
    else
      self.fullname = self.fullname.squeeze
    end
  end

  def verify_email_not_banned
    return unless banned?(self.email)
    errors.add(:base, 'You have been banned from creating an account.')
  end

  def create_settings_and_relations
    User.transaction do
      UserRelation.create!(user_id: self.id)
      Setting.create!(user_id: self.id)
    end
  end

end
