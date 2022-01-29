require 'simplecov'
require 'simplecov-lcov'

SimpleCov.start do
  coverage_dir '.coverage'
  add_filter 'node_modules'
  add_filter 'test'
  SimpleCov::Formatter::LcovFormatter.config do |c|
    c.report_with_single_file = true
    c.single_report_path = '.coverage/lcov.info'
  end
  formatter SimpleCov::Formatter::LcovFormatter
end

# vim:ft=ruby
