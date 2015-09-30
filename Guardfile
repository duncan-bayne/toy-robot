guard :rspec, cmd: "bundle exec rspec" do
  watch(%r{^spec/(.+)\.rb$})
  watch(%r{^toy_robot/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
end