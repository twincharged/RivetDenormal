module PGArrayMethods

##### append(), append_mult(), and remove() are nearly identical methods



  def append(field, value)
    klass = self.class
    klass = 'user_relation' if self.is_a?(User)
    query = self.class.connection.execute("UPDATE #{klass.to_s.downcase.pluralize} 
                                           SET #{field.to_s} = array_append(#{field.to_s}, #{value})
                                           WHERE id = #{self.id}
                                           RETURNING #{field.to_s}")
    return false unless query.is_a?(PG::Result)
    array = query[0][field.to_s].gsub(/[{}]/, "{" => "", "}" => "").split(",").map(&:to_i).uniq
    return {field.to_sym => array} if self.is_a?(User)
    self.send("#{field}=", array)
    return self
  end



  def append_mult(field, values)
    klass = self.class
    klass = 'user_relation' if self.is_a?(User)
    query = self.class.connection.execute("UPDATE #{klass.to_s.downcase.pluralize} 
                                           SET #{field.to_s} = array_cat(#{field.to_s}, ARRAY#{values})
                                           WHERE id = #{self.id}
                                           RETURNING #{field.to_s}")
    return false unless query.is_a?(PG::Result)
    array = query[0][field.to_s].gsub(/[{}]/, "{" => "", "}" => "").split(",").map(&:to_i).uniq
    return {field.to_sym => array} if self.is_a?(User)
    self.send("#{field}=", array)
    return self
  end



  def remove(field, value)
    klass = self.class
    klass = 'user_relation' if self.is_a?(User)
    query = self.class.connection.execute("UPDATE #{klass.to_s.downcase.pluralize} 
                                           SET #{field.to_s} = array_remove(#{field.to_s}, #{value}) 
                                           WHERE id = #{self.id}
                                           RETURNING #{field.to_s}")
    return false unless query.is_a?(PG::Result)
    array = query[0][field.to_s].gsub(/[{}]/, "{" => "", "}" => "").split(",").map(&:to_i).uniq
    return {field.to_sym => array} if self.is_a?(User)
    self.send("#{field}=", array)
    return self
  end



  def remove_mult(field, values)
    # not supported with simple psql function. its possible, but its ugly af
  end



  def reload_array(field)
    klass = self.class
    klass = 'user_relation' if self.is_a?(User)
    field = field.to_s
    loaded = self.class.find_by_sql("SELECT #{field}
                                     FROM #{klass.to_s.downcase.pluralize}
                                     WHERE id = #{self.id}").first.send(field)
    self.send("#{field}=", loaded.uniq)
    return self
  end



  def relate_with_array(field, related_class, limit=10)
    klass = self.class.name.underscore
    klass = UserRelation.name.underscore if self.is_a?(User)
    related_class.find_by_sql("SELECT * FROM #{related_class.to_s.downcase.pluralize}
                               WHERE id 
                               IN 
                              (SELECT unnest(#{field.to_s}) FROM #{klass.to_s.downcase.pluralize} WHERE id = #{self.id})
                               LIMIT #{limit}")
  end



end