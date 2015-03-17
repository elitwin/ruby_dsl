class Person
end

# Classes are factories which generate instances of themselves
# Thus, class_eval creates methods for instances of that class
Person.class_eval do
  def hello
    'hello'
  end
end
# is equivalent to:
#class Person
#  def hello
#    'hello'
#  end
#end


# Ruby evaluates string or block against the object receiving it - in
# this case, Person is an instance of Class
Person.instance_eval do
  # As a result, this is a class level method
  def goodbye
    'goodbye'
  end
end
# is equivalent to:
#class Person
#  def self.goodbye
#    'goodbye'
#  end
#end

Person2 = Class.new do
  def an_instance_method
    'used on instances of this class'
  end
end

puts Person.new.hello
#puts Person.hello # => NoMethodErrro
puts Person.goodbye
#puts Person.new.goodbye # => NoMethodError
puts Person2.new.an_instance_method
