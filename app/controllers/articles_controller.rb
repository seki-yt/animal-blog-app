class ArticlesController < ApplicationController
  #=> コントローラー名は複数系で書く
  def index
   @articles = Article.all
  end
  #=> indexは一覧を表示させるのに使われる

  def show
    @article = Article.find(params[:id])
  end
end