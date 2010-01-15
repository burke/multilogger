# Extend rails' logger to support multiple targets.
# Patterns are added with `add_log`, then when a message is added to the log,
# it is checked against the patterns.
# example:
#     logger = MultiLogger.new("log.txt")
#     logger.add_log("Delayed::Job", "dj_log.txt")
class MultiLogger < ActiveSupport::BufferedLogger

  # pattern can be either a String or a Regexp.
  def add_log(pattern, target)
    @extra_logs[pattern] = ActiveSupport::BufferedLogger.new(target)
    return self # just so we can't accidentally grab the sub-log and do something stupid with it.
  end

  def initialize(target, level=DEBUG)
    super(target, level)
    @extra_logs = {}
  end

  alias __old_add add

  def add(severity, message=nil, progname=nil, &block)
    @extra_logs.keys.each do |pattern|
      if message && message.match(pattern)
        return @extra_logs[pattern].add(severity, message, progname, &block)
      end
    end
    __old_add(severity, message, progname, &block)
  end

  # Set a few methods to also call on all the defined sub-logs.
  # This is handled a little inefficiently, but these won't be called often.
  [:auto_flush, :buffer, :clear_buffer, :silence, :auto_flushing=, :flush, :close].each do |method|
    alias_method "__old_#{method}".to_sym, method
    define_method method do |*args|
      @extra_logs.values.each{|e|e.method(method).call(*args)}
      method("__old_#{method}").call(*args)
    end
  end
  protected :auto_flush, :buffer, :clear_buffer
  
end
