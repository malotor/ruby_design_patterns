class SimpleLogger

  attr_accessor :level

  ERROR = 1
  WARNING = 2
  INFO = 3

  @@instance = SimpleLogger.new

  def self.instance
    return @@instance
  end

  def initialize
    @log = File.open("log.txt", "w")
    @level = self::WARNING
  end
  def error(msg)
    @log.puts(msg)
    @log.flush
  end
  def warning(msg)
    @log.puts(msg) if @level >= WARNING
    @log.flush
  end
  def info(msg)
    @log.puts(msg) if @level >= INFO
    @log.flush
  end

  # Private constructuo
  private_class_method :new

end


SimpleLogger.instance.warning('AE-35 hardware failure predicted.')
