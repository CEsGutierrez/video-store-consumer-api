ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "minitest/reporters"  # for Colorized output


#  For colorful output!
Minitest::Reporters.use!(
  Minitest::Reporters::SpecReporter.new,
  ENV,
  Minitest.backtrace_filter
)

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def check_response(expected_type:, expected_status: :ok)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'
    
    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end
end
