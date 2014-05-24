class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include PGArrayMethods
  include RedArrayMethods

  validates :username, presence: true, uniqueness: true, format: {with: /\A[A-Za-z0-9]+(?:[._-][A-Za-z0-9]+)*\z/i}, length: {minimum: 3, maximum: 20}
  validates :first_name, :last_name, format: {with: /\A[a-z ,.'-]+\z/i}, length: {minimum: 1, maximum: 20}
  validates :gender, inclusion: {in: %w( MALE FEMALE )}, allow_nil: true
  validate  :verify_email_not_banned
  before_save  :extract_university
  after_create :create_settings, :create_relations

##### Relations

  def posts
    self.relate_with_array(:owned_post_ids, Post)
  end

  def events
    self.relate_with_array(:owned_event_ids, Event)
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

  def added_events
    self.relate_with_array(:added_event_ids, Event)
  end

  def invited_events
    self.relate_with_array(:invited_event_ids, Event)
  end

  def settings
    Setting.find(self.id)
  end

###

  def followed_ids
    # self.relations.pluck(:followed_ids)
  end

  def follower_count
    self.follower_ids.count
  end

  def followed_count
    self.followed_ids.count
  end

  def relations
    UserRelation.find(self.id)
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

  def spark!(poly)
    poly.redappend(:sparker_ids, self.id)
  end

  def unspark!(poly)
    poly.redremove(:sparker_ids, self.id)
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

  def create_event!(attrs={})
    attrs[:user_id] = self.id
    event = Event.create!(attrs)
    self.append(:owned_event_ids, event.id)
    return event
  end

  def create_comment!(poly, attrs={})
    attrs[:user_id] = self.id
    attrs[:threadable] = poly
    comment = Comment.create!(attrs)
    poly.redappend(:comment_ids, comment.id)
    return comment
  end

  def create_group!(attrs={})
    attrs[:user_id] = self.id
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

  def add_event!(event)
    event.redappend(:added_user_ids, self.id)
    event.remove(:invited_user_ids, self.id) if event.public == false
    self.append(:added_event_ids, event.id)
    self.remove(:invited_event_ids, event.id) if event.public == false
  end

  def remove_event!(event)
    event.redremove(:added_user_ids, self.id)
    event.remove(:invited_user_ids, self.id) if event.public == false
    self.remove(:added_event_ids, event.id)
    self.remove(:invited_event_ids, event.id) if event.public == false
  end

###


  def post_feed1
    Post.where(user_id: self.followed_ids).limit(10)    # these feeds are nonworking due to lack of geolocation function.
  end

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
      BannedEmail.create(email: self.email, ban_report: reason)
      puts "#{self.email} is now banned!"
    else
      puts "#{self.email} not banned. Exiting function."
    end
  end

  def block_user!(user)
    self.redappend(:blocked_user_ids, user.id)
  end

  def banned?(email)
    BannedEmail.find_by(email: email).present?
  end

  def send_feedback!(attrs={})
    Feedback.create(user_id: self.id, subject: attrs[:subject], body: attrs[:body])
  end

  def blocked_user_ids
    self.redget(:blocked_user_ids)
  end


private


  def extract_university 
    return if self.entity == true
    if /[^.@]+\.edu$/ =~ self.email
      self.university = $&
    else
      self.university = "UNKNOWN"
    end
  end

  def create_settings
    Setting.create!(user_id: self.id)
  end

  def verify_email_not_banned
    return unless banned?(self.email)
    errors.add(:base, 'You have been banned from creating an account.')
  end

  def create_relations
    UserRelation.transaction do
      UserRelation.create(user_id: self.id)
    end
  end

end
