#!/usr/bin/env ruby

class Greeter
    def initialize(name = "World")
        @name = name
    end

    def say_hi
        puts "Hi #{@name}!"
    end

    def say_bye
        puts "Bye #{@name}, come back soon."
    end
end

g = Greeter.new("Sam")
g.say_hi()
g.say_bye()

a = "Hello world!"
[1,2,3].each do |num|
    puts a * num
end
