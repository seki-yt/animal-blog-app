class ArticlesController < ApplicationController
  #=> コントローラー名は複数系で書く
  before_action :set_article, only:[:show,]
  before_action :authenticate_user!, only:[:new, :create, :edit,:update, :destroy]
  before_action :set_user_article, only:[:edit, :update]

  def index
   @articles = Article.all
  end
  #=> indexは一覧を表示させるのに使われる

  def show
    
  end

  def new
    @article = current_user.articles.build
    #=> current_user.articles.buildでデータを入れる空の箱を作ってます
  end

  def create
    @article = current_user.articles.build(article_params)
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
    if @article.update(article_params)
      redirect_to article_path(@article), notice: '更新できました'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
    end
  end

  def destroy
    article = current_user.articles.find(params[:id])
    #=> @　付けないのはViewに表示しないため
    article.destroy!
    #=> ! つける理由は例外(アプリケーションがおかしい)が発生させないため
    redirect_to root_path, notice: '削除に成功しました'
  end

  private
  def article_params
    params.require(:article).permit(:title, :content, :eyecatch)
    #=> requireでarticleがないとだめと要求
    #=> permitでarticleのtitleとcontentだけを許す
  end

  def set_article
    @article = Article.find(params[:id])
    #=> @articleにしてるのはインスタンス変数のため
  end

  def set_user_article
    @article = current_user.articles.find(params[:id])
    #=> 対象の値を持ってくる
    #=> 必ずcurrent_user.articlesから持ってくるようにする。Article.findにしてしまうと全部もって来てしまうため他のユーザーのデータも変更できてしまう。
  end
end
