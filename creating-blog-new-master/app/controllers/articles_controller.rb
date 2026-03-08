class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :destroy]

  def index
    @articles = Article.order(id: :desc)
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to articles_path,
                  notice: I18n.t('label.create_success', model: Article.model_name.human)
    else
      flash[:error] = @article.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def destroy
    # 物理削除
    @article.destroy!
    redirect_to articles_path,
                notice: I18n.t('label.destroy_success', model: Article.model_name.human)
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :text)
  end
end
