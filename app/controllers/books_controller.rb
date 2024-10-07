class BooksController < ApplicationController
  def new
    @book = Book.new
    @user = current_user

  end



  def create
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      flash[:notice]
      render :new
    end
  end

  def index
    @books = Book.all
    @user = current_user
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @books = Book.includes(:favorited_users).
      sort_by {|x|
        x.favorited_users.includes(:favorites).where(created_at: from...to).size
      }.reverse
    @book = Book.new


  end

  def show
    @book = Book.new
    @books = Book.all
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
    read_count = ReadCount.new(book_id: @book.id, user_id: current_user.id)
    read_count.save
    current_user.read_counts.create(book_id: @book.id)
  end

  def edit
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end


  private

  def book_params
    params.require(:book).permit(:title, :body, :author)
  end
end
