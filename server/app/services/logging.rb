require 'logger'

module Logging

  def self.initialize_logger(log_target = STDOUT)
    if ENV['RACK_ENV'] == 'test'
      @logger = Logger.new(File.open(File::NULL, "w"))
      @logger.level = Logger::UNKNOWN
    else
      @logger = Logger.new(log_target)
      @logger.progname = 'API'
      @logger.level = ENV["DEBUG"] ? Logger::DEBUG : Logger::INFO
    end
    @logger
  end

  def self.logger
    defined?(@logger) ? @logger : initialize_logger
  end

  def self.logger=(log)
    @logger = (log ? log : Logger.new('/dev/null'))
  end

  def logger
    Logging.logger
  end

  # Send a debug message
  # @param [String] string
  def debug(string)
    logger.debug(self.class.name) { string }
  end

  # Send a info message
  # @param [String] string
  def info(string)
    logger.info(self.class.name) { string }
  end

  # Send a warning message
  # @param [String] string
  def warn(string)
    logger.warn(self.class.name) { string }
  end

  # Send an error message
  # @param [String] string
  def error(string)
    logger.error(self.class.name) { string }
  end
end
