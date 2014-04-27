# Examiner

Grade a student's exercise solution.

Assumptions:

- The exercise uses [minitest](https://github.com/seattlerb/minitest) to be checkied
- There is a `Rakefile` in the exercise folderx

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'examiner'
```

And then execute:

    $ bundle

## Usage

You can quickly grade a student's exercise solution with
the following code.

```ruby
exercise_directory = "/path/to/student_exercise_with_rakefile"

runner = Examiner::RakeRunner.new
runner.run exercise_directory
if runner.success?
  puts "Results: #{runner.tests - runner.failures}/#{runner.tests}"
end

# You can display stdout and stderr
puts runner.stdout_lines.join
puts runner.stderr_lines.join
```
