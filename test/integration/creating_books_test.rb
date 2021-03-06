require 'test_helper'

class CreatingBooksTest < ActionDispatch::IntegrationTest
  test 'creates books with valid data' do
    post '/api/books', { book: book_attributes }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }

    book = json(response.body)[:book]
    assert_equal api_book_url(book[:id]), response.location
    assert_equal Mime::JSON, response.content_type
    assert_equal 'Pragmatic Programmer', book[:title]
    assert_equal 5, book[:rating]
    assert_equal 'Dave Thomas', book[:author]
    assert_equal 1, book[:genre_id]
    assert_equal 'Excellent ...', book[:review]
    assert_equal '13123', book[:amazon_id]
    assert_equal 201, response.status
  end

  test 'does not create books with invalid data' do
    post '/api/books', { book: {
        title: nil,
        rating: 5
      } }.to_json,
      {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }

    assert_equal 422, response.status
  end

  def book_attributes
    {
      title: 'Pragmatic Programmer',
      rating: 5,
      author: 'Dave Thomas',
      genre_id: 1,
      review: 'Excellent ...',
      amazon_id: '13123'
    }
  end
end
