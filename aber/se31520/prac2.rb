#!/usr/bin/ruby

# Testing some functions
def hello(programmer)
    puts "Hello #{programmer}"
end

hello('Sam')

#Testing some class definitions and inheritence

class Person
    def initialize(name)
        @name = name
    end

    def greet()
        puts "Hello world. My name is #{@name}."
    end
end

p = Person.new("Sam")
p.greet

class Sam < Person
    def initialize()
        super("Sam Jackson")
    end
end

sam = Sam.new()
sam.greet

def greet_all(*names)
    for name in names
        puts name
    end
    case names.length
    when 0
        puts "List of names was empty!"
    when 1
        puts "We had one name!"
    else
        puts "We had lots of names!"
    end
end

greet_all()
greet_all('Sam')
greet_all('Sam', 'Bob')

def explain_product(a,b)
    "The result of #{a} times #{b} is #{a * b}."
end

puts explain_product(2,3)
