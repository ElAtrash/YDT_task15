class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.where('created_at >= ?', 1.week.ago)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        ActionCable.server.broadcast('notification_channel', "New Article #{@article.title} has been created")
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.js
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @article.update(article_params)
        ActionCable.server.broadcast('notification_channel', "The Article #{@article.title} has been updated")
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.js
      else
        format.html { render :edit }
        format.js
      end
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      ActionCable.server.broadcast('notification_channel', "The Article #{@article.title} has been deleted")
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.js
    end
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :body)
    end
end
