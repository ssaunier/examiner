require "spec_helper"
require "examiner/minitest_parser"

module Exmanier
  describe "MinitestParser" do
    let(:parser) { Examiner::MinitestParser.new }

    describe "#parse" do
      it "must not raise if given nil" do
        parser.parse nil
        parser.success?.must_equal false
      end

      it "must not raise if given an empty array" do
        parser.parse []
        parser.success?.must_equal false
      end

      it "must parse correctly a Minitest stdout" do
        lines = [ "", "4 runs, 3 assertions, 3 failures, 0 errors, 0 skips", "rake aborted!" ]
        parser.parse lines
        parser.tests.must_equal 4
        parser.failures.must_equal 3
        parser.success?.must_equal true
      end
    end
  end
end
