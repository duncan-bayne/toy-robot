require 'rake'
require 'rspec/core/rake_task'

task default: [ :specs, :quality, :documentation ]

RSpec::Core::RakeTask.new(:specs) do |spec|
  spec.pattern = 'spec/*_spec.rb'
  spec.rspec_opts = ['--backtrace']
end

task :documentation do
  system('markdown')
end

task :quality do
  system('roodi -config=roodi.yml "**/*.rb"')
end
