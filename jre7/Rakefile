require 'rake'

require 'rspec/core/rake_task'
require 'puppet-lint'
require 'ci/reporter/rake/rspec'

# RSpec::Core::RakeTask.new(:spec) => ["ci:setup:rspec"] do |t|
#   t.pattern = 'spec/*/*_spec.rb'
# end

desc "Run puppet-lint."
task :lint do |t, args|
  PuppetLint.configuration.log_format = "%{path}:%{linenumber}:%{check}:%{KIND}:%{message}"
  PuppetLint.configuration.send('disable_80chars')
  linter = PuppetLint.new
  files = File.join("**", "*.pp")
  Dir.glob(files).each do |puppet_file|
    puts "Evaluating #{puppet_file}"
    linter.file = puppet_file
    linter.run
  end
  fail if linter.errors?
end

