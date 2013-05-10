#!/usr/bin/env ruby

$LOAD_PATH << 'lib'

%w(stack_machine).each{|f| require_relative "lib/#{f}"}

puts StackMachine.new.process("13+62*7+*")
