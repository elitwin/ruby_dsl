require 'direction'

class Person
  extend Direction

  command [:print_address] => :home
  # expands to
  #def print_address(template)
  #  home.print_address(template)
  #  self
  #end

  #def print_address_x(template)
  #  home.print_address(template)
  #end

  attr_accessor :home
end

class Home
  def print_address(template)
    template << "... printing the address ...\n"
  end
end

template = STDOUT
person = Person.new
person.home = Home.new
# commands won't leak internal structure
person.print_address(template)
# person.print_address(template).class # -> returns Person
# person.print_address_x(template).class # -> returns template - IO in this case
