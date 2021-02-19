class ArticlesController < ApplicationController
  #=> コントローラー名は複数系で書く
  def index
   @articles = Article.all
  end
  #=> indexは一覧を表示させるのに使われる

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
    #=> Article.newでデータを入れる空の箱を作ってます
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      # => これで保存するよ
      redirect_to article_path(@article), notice: '保存できたよ'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new
    end

  end

  private
  def article_params
    params.require(:article).permit(:title, :content)
    #=> requireでarticleがないとだめと要求
    #=> permitでarticleのtitleとcontentだけを許す
  end
end