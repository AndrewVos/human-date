require 'bundler/gem_tasks'

require 'rake/testtask'
Rake::TestTask.new do |t|
    t.pattern = "test/test_*.rb"
end

require 'erb'
task :examples do
  require_relative 'lib/human-date'
  template = ERB.new(File.read('examples/example.erb'))
  puts template.result(binding)
end
