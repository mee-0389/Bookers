class BooksController < ApplicationController
  def new
  end

  def create #投稿の保存機能
    @book = Book.new(book_params) #データを受け取って新規登録するためのインスタンス作成
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id) #詳細画面へリダイレクト
    else
      @books = Book.all
      render :index
    end
  end

  def index #投稿画面と一覧画面
    @books = Book.all #一覧画面用
    @book = Book.new #投稿画面用。Viewへ渡すためのインスタンス変数に空のmoduleオブジェクトを生成する
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
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
    params.require(:book).permit(:title, :body)
  end
end
