require 'simplecov'
require 'simplecov-lcov'
require 'simplecov-table'

SimpleCov.start do
  coverage_dir '.coverage'
  add_filter 'node_modules'
  add_filter 'test'
end

SimpleCov::Formatter::LcovFormatter.config do |c|
  c.single_report_path = '.coverage/lcov.info'
  c.report_with_single_file = true
end

SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::LcovFormatter,
  SimpleCov::Formatter::TableFormatter,
])

# vim:ft=ruby
