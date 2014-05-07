require 'open3'
require_relative 'minitest_parser'

module Examiner
  class RakefileMissingError < StandardError; end
  class MissingDefaultRakeTaskError < StandardError; end

  class RakeRunner
    attr_reader :stdout_lines, :stderr_lines
    attr_reader :tests, :failures

    def initialize
      @tests, @failures = 0, 0
      @stdout_lines, @stderr_lines = [], []
      @success = false
    end

    def run(directory)
      raise RakefileMissingError.new(directory) unless rakefile?(directory)

      Open3.popen3('rake', chdir: directory) do |_, stdout, stderr, wait_thr|
        @stdout_lines, @stderr_lines = stdout.readlines, stderr.readlines
        parse_stderr(directory)
        parse_stdout
      end
    end

    private

      def parse_stderr(directory)
        unless MinitestParser.new.default_rake?(@stderr_lines)
          raise MissingDefaultRakeTaskError.new(directory)
        end
      end

      def parse_stdout
        parser = MinitestParser.new
        parser.parse @stdout_lines
        if parser.success?
          @tests = parser.tests
          @failures = parser.failures
        end
      end

      def rakefile?(directory)
        File.exists?(File.join(directory, 'Rakefile'))
      end
  end
end
