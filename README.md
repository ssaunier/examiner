[![Build Status](https://travis-ci.org/ssaunier/examiner.svg?branch=master)](https://travis-ci.org/ssaunier/examiner)
[![Gem Version](https://badge.fury.io/rb/examiner.svg)](http://badge.fury.io/rb/examiner)

# Examiner

Grade a student's exercise solution, assuming:

- The exercise uses [minitest](https://github.com/seattlerb/minitest) to be checked
- There is a `Rakefile` in the exercise folder

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'examiner'
```

And then execute:

```bash
$ bundle
```

## Usage

You can quickly grade a student's exercise solution with
the following code.

```ruby
exercise_directory = "/path/to/student_exercise_with_rakefile"

runner = Examiner::RakeRunner.new
begin
  runner.run exercise_directory
  puts "Results: #{runner.tests - runner.failures}/#{runner.tests}"
rescue Examiner::RakefileMissingError => e
  puts "Folder does not have any Rakefile"
rescue Examiner::MissingDefaultRakeTaskError => e
  puts "Could not launch tests with 'rake'"
end

# You can display stdout and stderr
puts runner.stdout_lines.join
puts runner.stderr_lines.join
```
