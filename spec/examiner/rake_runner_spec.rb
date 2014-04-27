require "spec_helper"
require "examiner/rake_runner"

module Exmanier
  describe "RakeRunner" do
    let(:runner) { Examiner::RakeRunner.new }

    it "should handle a folder without Rakefile" do
      runner.run directory("no_rake_file")
      runner.success?.must_equal false
    end

    it "should be successful for 1_test_0_failure use case" do
      runner.run directory("1_test_0_failure")
      runner.success?.must_equal true
      runner.tests.must_equal 1
      runner.failures.must_equal 0
      runner.stdout_lines.wont_be_empty
      runner.stderr_lines.must_be_empty
    end

    it "should be successful for 2_tests_1_failure use case" do
      runner.run directory("2_tests_1_failure")
      runner.success?.must_equal true
      runner.tests.must_equal 2
      runner.failures.must_equal 1
      runner.stdout_lines.wont_be_empty
      runner.stderr_lines.must_be_empty
    end

    it "should handle a file with syntax errors" do
      runner.run directory("syntax_error")
      runner.success?.must_equal false
    end

    def directory(name)
      File.expand_path("../../support/#{name}", __FILE__)
    end
  end
end