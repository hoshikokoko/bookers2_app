class BooksController < ApplicationController
  
  before_action :is_matching_login_user, only: [:edit, :updat ]
  
  def index
    @booknew = Book.all
    @booknew = Book.new
    @booker = current_user
    @books = Book.all
  end
  
  def create
    @booknew = Book.new(book_params)
    @booknew.user_id = current_user.id
    if @booknew.save
      flash[:notice] = "You have created book successfully!"
      redirect_to book_path(@booknew.id)
    else
      @booker = current_user
      @books = Book.all
      render :index
    end
  end
  
  def show
    @book = Book.find(params[:id])
    @booker = @book.user
    @booknew = Book.new
  end
  
  def edit
    @book = Book.find(params[:id])
    @booker = current_user
    @booknew = Book.new
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully!"
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  
  
  private

  def book_params
    params.require(:book).permit(:title, :body, :image)
  end
  
    
  def is_matching_login_user
    user_id = params[:id].to_i
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to books_path
    end
  end
end
