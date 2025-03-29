# frozen_string_literal: true

require "bundler/gem_tasks"

# Setup +Rake+ task to run all +Minitest+ specs.
require "minitest/test_task"
Minitest::TestTask.create

# Setup +Rake+ task to run +StandardRB+ linter checks.
require "standard/rake"

task default: %i[test standard]
