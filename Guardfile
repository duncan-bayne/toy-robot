def ctags?
  system('ctags-exuberant --version > /dev/null')
end

guard :rspec, cmd: "bundle exec rspec" do
  watch(%r{^spec/(.+)\.rb$})
  watch(%r{^toy_robot/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
end

if ctags?
  guard 'ctags-bundler', :src_path => ['spec', 'toy_robot'], :binary => 'ctags-exuberant', :emacs => true do
    watch(/^(spec|toy_robot)\/.*\.rb$/)
    watch('Gemfile.lock')
  end
else
  Compat::UI.warning('ctags-exuberant not found on PATH; skipping TAGS generation.')
end
