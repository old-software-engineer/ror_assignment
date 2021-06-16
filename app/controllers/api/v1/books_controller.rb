class Api::V1::BooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_book, only: [:show, :update, :destroy]
  before_action :set_admin_user,  only: [:index, :create]

  # GET /books
  def index
    @books = @admin_user.books.all
    render json: @books
  end

  # GET /books/1
  def show
    render json: @book
  end

  # POST /books
  def create
    if @admin_user
      @book = @admin_user.books.build(book_params)
      if @book.save
        render json: @book, status: :created, location: api_v1_book_url(@admin_user,@book)
      else
        render json: @book.errors, status: :unprocessable_entity
      end
    else
      render json: {error: "Admin user doesn't exist"}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /books/1
  def update
    if @book.update(book_params)
      render json: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /books/1
  def destroy
    @book.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:id])
  end

  def set_admin_user
    @admin_user = AdminUser.find(params[:admin_user_id])
  end

  # Only allow a trusted parameter “white list” through.
  def book_params
    params.permit(:name, :price)
  end
end