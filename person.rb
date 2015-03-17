class Person
  def self.species
    "Homo Sapien"
  end
end

class Person2; end
Person2.class_eval do
  def species
    "Homo Sapien2"
  end
end

class Person3; end
# set self to Person3's metaclass for duration of block
class << Person3
  def species
    "Homo Sapien3"
  end
end

class Person4; end
# Open Person4
class Person4
  # set self to Person4's metaclass
  class << self
    def species
      "Homo Sapien4"
    end
  end
end

class Person5; end
# instance_eval breaks apart self into 2 parts
# 1: the self used to execute methods
# 2: the self used when new methods are defined
Person5.instance_eval do
  def species
    "Home Sapien5"
  end
end

puts Person.name
puts Person.species
puts '-----'
puts Person2.name
puts Person2.new.species
puts '-----'
puts Person3.name
puts Person3.species
puts '-----'
puts Person4.name
puts Person4.species
puts '-----'
puts Person5.name
puts Person5.species
