#!/usr/bin/env ruby
require 'erb'
require 'digest'
require 'mixlib/shellout'

machine_id  = File.read('/etc/machine-id')
machine_sha = Digest::SHA512.hexdigest(machine_id)

pre = (ARGV[0] =~ /-{1,2}pre$/)
post = (ARGV[0] =~ /-{1,2}post$/)

def parse_i3_config_template(erb_template)
  machine_id  = File.read('/etc/machine-id')
  machine_sha = Digest::SHA512.hexdigest(machine_id)

  erb_template.result(binding).split("\n").each do |line|
    next unless line =~ /^\w/
    if ENV['DEBUG']
      puts line
    else
      cmd = Mixlib::ShellOut.new('i3-msg', line)
      cmd.run_command
      cmd.error!
    end
  end
end

if pre
  default_template = File.join(File.dirname(__FILE__), 'template.erb')
  template  = ENV.key?('I3_TEMPLATE') ? ENV['I3_TEMPLATE'] : default_template
  i3_config = ERB.new(File.read(template))

  parse_i3_config_template(i3_config)
end

if post
  workspace_path = File.join(ENV['HOME'], '.config/i3/workspaces', machine_sha)

  Dir.glob(File.join(workspace_path, '*.json')).each do |file|
    workspace_name = File.basename(file, '.json')
    next unless workspace_name == ARGV[1] && ARGV[1]
    if ENV['DEBUG']
      puts file
      template = File.join(File.dirname(file), workspace_name + '.i3')
      puts "there's also a template, #{workspace_name}.i3" if File.exist?(template)
    else
      line = "workspace #{workspace_name}; append_layout #{file}"

      # load layout
      layout = Mixlib::ShellOut.new('i3-msg', line)
      layout.run_command
      puts layout.stderr
      layout.error!
      
      # execute associated commands
      template = File.join(File.dirname(file), workspace_name + '.i3')
      if File.exist?(template)
        i3_config = ERB.new(File.read(template))
        parse_i3_config_template(i3_config)
      end
    end
  end
end
