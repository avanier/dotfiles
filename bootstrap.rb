#!/bin/env ruby
require 'mixlib/shellout'

folders = []

Dir.glob('*').each do |i|
    folders << i if File.directory?(i) && /^(?!_)/.match(i)
end

folders.each do |f|
    cmd = Mixlib::ShellOut.new('echo', "stow --restow --verbose 1 --target=#{ENV['HOME']} #{f}")
    cmd.run_command
    cmd.error!
    puts cmd.stdout
end
