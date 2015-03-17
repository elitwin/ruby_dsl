require 'ostruct'

module Olaf
  def self.configure(&block)
    # evaluates block on the current self object
    instance_eval(&block)
    # alternative implementation
    #self.instance_eval(&block)
  end

  def self.likes_warm_hugs(value)
    @likes_warm_hugs = value
  end

  def self.likes_warm_hugs?
    @likes_warm_hugs
  end

  class << self
    #attr_accessor :likes_warm_hugs

    def to_s
      'Hi there, I\'m Olaf'
    end
  end

  marshmallow = OpenStruct.new(angry: false)

  # Also, implicit block should not be able to access marshmallow
  # This works though
  Olaf.configure do
    likes_warm_hugs !marshmallow.angry
  end
end

# This now works outside of module due to declarative setters/getters
#Olaf.configure do
#  likes_warm_hugs true
#end

puts "Likes warm hugs: #{Olaf.likes_warm_hugs?}" # This ends up setting
#puts "Methods: #{Olaf.instance_methods.sort}"
#puts "Private Methods: #{Olaf.private_methods.sort}"
#puts "Ancestors: #{Olaf.ancestors}"
puts "to_s: #{Olaf.to_s}"
