require 'rubygems'
require 'puppet_blacksmith/rake_tasks'
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'yamllint/rake_task'

exclude_paths = [
  "vendor/**/*",
  "site/*/vendor/**/*",
  "site/*/spec/**/*",
]

PuppetLint::RakeTask.new :lint do |config|
  config.fail_on_warnings = true
  config.ignore_paths = exclude_paths
  config.log_format = "%{path}:%{line}:%{check}:%{KIND}:%{message}"
end

PuppetSyntax.exclude_paths = exclude_paths

desc "Validate manifests, templates, and ruby files"
task :validate do
  Dir['manifests/**/*.pp'].each do |manifest|
    sh "puppet parser validate --noop #{manifest}"
  end
  Dir['site/*/manifests/**/*.pp'].each do |manifest|
    sh "puppet parser validate --noop #{manifest}"
  end
  Dir['site/*/spec/**/*.rb','lib/**/*.rb'].each do |ruby_file|
    sh "ruby -c #{ruby_file}" unless ruby_file =~ /spec\/fixtures/
  end
  Dir['site/*/templates/**/*.erb'].each do |template|
    sh "erb -P -x -T '-' #{template} | ruby -c"
  end
end

YamlLint::RakeTask.new do |yamllint|
  yamllint.paths = %w(
    *.yml
    hieradata/**/*.yml
    hieradata/**/*.yaml
  )
end

task :tests do
  Rake::Task[:lint].invoke
  Rake::Task[:validate].invoke
  Rake::Task[:yamllint].invoke
  Rake::Task[:spec].invoke
end
