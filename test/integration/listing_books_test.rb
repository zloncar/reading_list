require_relative '../test_helper.rb'

class ListingBooksTest < ActionDispatch::IntegrationTest
  setup do
    @scifi = Genre.create!(name: 'Science Fiction')
    @scifi.books.create!(title: "Ender's Game", rating: 5)
    @scifi.books.create!(title: 'Star Trek', rating: 4)
  end

  test 'listing books' do
    get '/books'

    assert_equal Mime::JSON, response.content_type
    assert_equal 200, response.status
    books = json(response.body)[:books]
    book = Book.find(books.first[:id])
    assert_equal Book.count, books.size
    assert_equal @scifi.id, book.genre.id
  end

  test 'listing top rated books' do
    get '/books?rating=5'

    assert_equal Mime::JSON, response.content_type
    assert_equal 200, response.status
    assert_equal 1, json(response.body)[:books].size
  end
end
