require_relative '../test_helper'

class ListingFinishedBooksTest < ActionDispatch::IntegrationTest
  test 'list finished books in JSON' do
    get '/finished_books', {}, { 'Accept' => 'application/json' }

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
  end

  test 'list finished books in XML' do
    get '/finished_books', {}, { 'Accept' => 'application/xml' }

    assert_equal 200, response.status
    assert_equal Mime::XML, response.content_type
  end
end
