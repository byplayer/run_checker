# -*- coding: utf-8 -*-
require 'log4r'
require 'English'

# This is class to check duplicated run
class RunChecker
  # [lock_path]
  #   lock file path
  # [logger]
  #   logger instance, it is expected a instance of Logger in Log4r.
  #   If you don't set logger or you set nil for this param,
  #   log information will be put to stdout via StdoutOutputter.
  def initialize(lock_path, logger = nil)
    @lock_path = lock_path
    @logger = logger

    return if @logger

    formatter = Log4r::PatternFormatter.new(pattern: '%d [%l]:%p: %M',
                                            date_format: '%Y.%m.%d %H:%M:%S')
    outputter = Log4r::StdoutOutputter.new('RunCheckerOutPutter',
                                           formatter: formatter)
    @logger = Log4r::Logger.new('RunChecker')
    @logger.add(outputter)
  end

  # lock
  # [return]
  #   If this method returns true, other process didn't run.
  #   If this method returns false, other process runs.
  def lock
    if File.exist? @lock_path
      pid = 0
      File.open(@lock_path, 'r') do |f|
        pid = f.read.chomp!.to_i
      end

      if exist_process(pid)
        @logger.info("other process is running: pid(#{pid})")
        return false
      else
        @logger.warn("process was finished pid(#{pid}), " +
                      'cleanup lock file and start new process')
        File.delete(@lock_path)
      end
    end

    File.open(@lock_path, 'w') do |f|
      locked = f.flock(File::LOCK_EX | File::LOCK_NB)
      if locked
        f.puts $PROCESS_ID
        return true
      else
        @logger.error("lock failed -> pid: #{$PID}")
        return false
      end
    end
  end

  def cleanup
    return unless File.exist? @lock_path

    pid = 0
    File.open(@lock_path, 'r') do |f|
      pid = f.read.chomp!.to_i
    end

    if pid == $PROCESS_ID
      File.delete(@lock_path)
    else
      @logger.info('lock file was created by other process')
    end
  end

  private

  def exist_process(pid)
    Process.getpgid(pid)
    return true
  rescue => ex
    @logger.info("check process error pid(#{pid}): #{ex}\n" +
                  ex.backtrace.join("\n  "))
    return false
  end
end
