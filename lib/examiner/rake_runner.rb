require 'open3'
require_relative 'minitest_parser'

module Examiner
  class RakeRunner
    attr_reader :stdout_lines, :stderr_lines
    attr_reader :tests, :failures

    def initialize
      @tests, @failures = 0, 0
      @stdout_lines, @stderr_lines = [], []
      @success = false
    end

    def run(directory)
      return unless rakefile?(directory)

      Open3.popen3('rake', chdir: directory) do |_, stdout, stderr, wait_thr|
        @stdout_lines, @stderr_lines = stdout.readlines, stderr_lines
        parse_stdout
      end
    end

    def success?
      @success
    end

    private

      def parse_stdout
        parser = MinitestParser.new
        parser.parse @stdout_lines
        if parser.success?
          @tests = parser.tests
          @failures = parser.failures
          @success = true
        end
      end

      def rakefile?(directory)
        File.exists?(File.join(directory, 'Rakefile'))
      end
  end
end
