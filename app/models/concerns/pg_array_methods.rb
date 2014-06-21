module PGArrayMethods

  def self.included(klass)
    klass.class_eval do
      extend PGClassMethods
    end
  end

protected


  def append(field, value)
    klass = self.is_a?(User) ? UserRelation.name.underscore : self.class
    ex(field, value, self, "UPDATE #{klass.to_s.downcase.pluralize} 
                                           SET #{field.to_s} = array_append(#{field.to_s}, #{value})
                                           WHERE id = #{self.id}
                                           RETURNING #{field.to_s}")
  end


  def append_mult(field, values)
    klass = self.is_a?(User) ? UserRelation.name.underscore : self.class
    ex(field, values, self, "UPDATE #{klass.to_s.downcase.pluralize} 
                                           SET #{field.to_s} = array_cat(#{field.to_s}, ARRAY#{values})
                                           WHERE id = #{self.id}
                                           RETURNING #{field.to_s}")
  end


  def remove(field, value)
    klass = self.is_a?(User) ? UserRelation.name.underscore : self.class
    ex(field, value, self, "UPDATE #{klass.to_s.downcase.pluralize} 
                                           SET #{field.to_s} = array_remove(#{field.to_s}, #{value}) 
                                           WHERE id = #{self.id}
                                           RETURNING #{field.to_s}")
  end


  def remove_mult(field, values)
    # not supported with simple psql function. it's possible, but it's ugly af
  end


  def relate_with_array(field, related_class, limit=100)
    klass = self.is_a?(User) ? UserRelation.name.underscore : self.class
    related_class.find_by_sql("SELECT * FROM #{related_class.to_s.downcase.pluralize}
                               WHERE id 
                               IN 
                              (SELECT unnest(#{field.to_s}) FROM #{klass.to_s.downcase.pluralize} WHERE id = #{self.id})
                               LIMIT #{limit}")
  end


  def get(field)
    klass = self.is_a?(User) ? UserRelation.name.underscore : self.class
    query = self.class.connection.execute("SELECT #{field.to_s}
                                           FROM #{klass.to_s.downcase.pluralize}
                                           WHERE id = #{self.id}")
    # return false unless query.is_a?(PG::Result)
    array = query[0][field.to_s].uniq #.gsub(/[{}]/, "{" => "", "}" => "").split(",").map(&:to_i).uniq
  end


  def ex(field, values, object, sql)
    query = object.class.connection.execute(sql)
    # return false unless query.is_a?(PG::Result)
    array = query[0][field.to_s].uniq #.gsub(/[{}]/, "{" => "", "}" => "").split(",").map(&:to_i).uniq
    return {field.to_sym => array} if object.is_a?(User)
    object.send("#{field}=", array)
    return object
  end

##### Not for array:

  module PGClassMethods
    def find_stub(id)
      if id.is_a?(Integer)
        self.find_by_sql("SELECT id, avatar, username, fullname
                          FROM users
                          WHERE id = #{id}")
      elsif id.is_a?(Array)
        id = id.to_s.delete("[]")
        self.find_by_sql("SELECT id, avatar, username, fullname
                          FROM users
                          WHERE id IN (#{id})")
      end
    end
  end


end