require 'rake'
require 'rspec/core/rake_task'
require 'roodi'
require 'roodi_task'

desc 'Runs all specs and quality tests, then generates documentation'
task default: [ :specs, :roodi, :documentation ]

RSpec::Core::RakeTask.new(:specs) do |spec|
  spec.pattern = 'spec/*_spec.rb'
  spec.rspec_opts = ['--backtrace']
end

desc 'Generates HTML documentation from Markdown files'
task :documentation do
  system('redcarpet README.md > README.html') or raise 'unable to generate README.html'
  system('redcarpet doc/specification.md > doc/specification.html') or raise 'unable to generate specification.html'
end

RoodiTask.new do |t|
  t.verbose = true
  t.config = File.dirname(__FILE__) + '/roodi.yml'
  t.patterns = [ '**/*.rb' ]
end
