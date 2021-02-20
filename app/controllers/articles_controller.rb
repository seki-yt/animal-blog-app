class ArticlesController < ApplicationController
  #=> コントローラー名は複数系で書く
  before_action :set_article, only:[:show, :edit, :update]

  def index
   @articles = Article.all
  end
  #=> indexは一覧を表示させるのに使われる

  def show
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

  def edit
  end

  def update
    #=>まずは対象の値を持ってくる↓
    if @article.update(article_params)
      redirect_to article_path(@article), notice: '更新できました'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
    end
  end

  def destroy
    article = Article.find(params[:id])
    #=> @　付けないのはViewに表示しないため
    article.destroy!
    #=> ! つける理由は例外(アプリケーションがおかしい)が発生させないため
    redirect_to root_path, notice: '削除に成功しました'
  end

  private
  def article_params
    params.require(:article).permit(:title, :content)
    #=> requireでarticleがないとだめと要求
    #=> permitでarticleのtitleとcontentだけを許す
  end

  def set_article
    @article = Article.find(params[:id])
    #=> @articleにしてるのはインスタンス変数のため
  end

end