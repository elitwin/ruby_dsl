module Sven
  def self.configure(&block)
    block.call(self)
    # alternative implementation
    # yield self
  end

  # Keep all class methods in the same block
  class << self
    attr_accessor :likes_carrots, :better_than_people

    def to_s
      'I am Sven'
    end
  end
end

people = ['Elsa', 'Hans']
Sven.configure do |reindeer|
  reindeer.likes_carrots = true
  unless people.include?('Anna')
    reindeer.better_than_people = true
  end
end

puts "Likes carrots: #{Sven.likes_carrots}"
puts "Better than people: #{Sven.better_than_people}"
#puts "Methods: #{Sven.instance_methods.sort}"
#puts "Private Methods: #{Sven.private_methods.sort}"
#puts "Ancestors: #{Sven.ancestors}"
puts "to_s: #{Sven.to_s}"
