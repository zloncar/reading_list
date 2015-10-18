class BooksController < ApplicationController
  def index
    books = Book.all

    if rating = params[:rating]
      books = books.where(:rating => rating)
    end
    render json: books, status: 200
  end

  def create
    book = Book.new(book_params)
    if book.save
      # render json: book, stauts: 201, location: book
      render json: book, status: 201, location: book
    else
      # p book.errors.messages
      render json: book.errors, status: 422
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy!
    render nothing: true, status: 204
  end
  # def show
  #   book = Book.find(params[:id])
  #   render json: book, status: 200
  # end

  def book_params
    params.require(:book).permit(:title, :rating, :author, :review, :genre_id, :amazon_id)
  end
end
