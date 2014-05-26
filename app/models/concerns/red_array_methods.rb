module RedArrayMethods
  require 'redis'

  def self.included(klass)
    klass.class_eval do
      extend RedisConnection
    end
  end

protected

  def self.redis
    @redis ||= Redis.new
  end

  def redappend(field, value)
    self.class.redis.sadd("#{self.class.to_s.downcase}:#{self.id}:#{field}", value)
  end

  def redappend_mult(field, values)
    self.class.redis.sadd("#{self.class.to_s.downcase}:#{self.id}:#{field}", values)
  end

  def redremove(field, value)
    self.class.redis.srem("#{self.class.to_s.downcase}:#{self.id}:#{field}", value)
  end

  def redget(field)
    self.class.redis.smembers("#{self.class.to_s.downcase}:#{self.id}:#{field}").map(&:to_i)
  end

  def redcount(field)
    self.class.redis.scard("#{self.class.to_s.downcase}:#{self.id}:#{field}")
  end

  def redrelate_with_array(field, related_class, limit=10)
    related_class.find(self.redget(field)).limit(limit)
  end

  module RedisConnection
    def redis
      @@redis ||= Redis.new
    end
  end

end