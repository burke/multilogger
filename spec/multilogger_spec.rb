require 'rubygems'
require 'active_support'
require File.join(File.dirname(__FILE__),'../lib/multilogger.rb')

describe MultiLogger do

  before do
    @target = StringIO.new
    @alt_target = StringIO.new
    @log = MultiLogger.new(@target)
    @log.add_log(/p[aA]ttern/, @alt_target)
  end
  
  it "should log messages to the supplied IO object" do
    @log.fatal("This will go to the main log.")
    @target.rewind
    @target.read.should == "This will go to the main log.\n"
    @alt_target.rewind
    @alt_target.read.should == ""
  end

  it "should split messages that match supplied patterns into their respective alternate log files" do
    @log.fatal("This matches the pattern, and will go to the alternate log.")
    @target.rewind
    @target.read.should == ""
    @alt_target.rewind
    @alt_target.read.should == "This matches the pattern, and will go to the alternate log.\n"
  end

end
