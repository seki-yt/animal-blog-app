class ArticlesController < ApplicationController
  #=> コントローラー名は複数系で書く
  def index
   @article = Article.first
  end

  def about
    render 'home/about'
  end
end