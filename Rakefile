require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "multilogger"
    gem.summary = "Split Rails logging into multiple log files"
    gem.description = "Multilogger pattern matches incoming log messages to decide which log file to write them to."
    gem.email = "burke@burkelibbey.org"
    gem.homepage = "http://github.com/burke/multilogger"
    gem.authors = ["Burke Libbey"]
    gem.files.include '{spec,lib}/**/*'
    gem.add_dependency "active_support"
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'spec'
    test.pattern = 'spec/**/*_spec.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "multilogger #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
