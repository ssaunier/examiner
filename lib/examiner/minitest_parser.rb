module Examiner
  class MinitestParser
    attr_reader :tests, :failures

    def initialize
      @tests, @assertions, @failures, @errors, @skips = 0, 0, 0, 0, 0
      @success = false
    end

    def parse(lines)
      return unless lines.kind_of? Enumerable

      lines.reverse_each.each do |line|
        result = PATTERN.match line
        if result
          result.names.zip(result.captures.map(&:to_i)).each do |feature, number|
            instance_variable_set :"@#{feature}", number
          end
          @success = true
          break
        end
      end
    end

    def default_rake?(lines)
      lines.reverse_each.each do |line|
        return false if /Don't know how to build task 'default'/.match line
      end
      true
    end

    def success?
      @success
    end

    private
      PATTERN = /(?<tests>\d+) (tests|runs), (?<assertions>\d+) assertions, (?<failures>\d+) failures, (?<errors>\d+) errors, (?<skips>\d+) skips/
  end
end