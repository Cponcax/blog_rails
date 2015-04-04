class ArticlesController < ApplicationController
  #para validar sessiones
  # before_action :validate_user, except: [:show, :index]

  #ese es un helper de devise  que valida session 
  before_action :authenticate_user!, except: [:show, :index]
  #este es un callback que no sirve para recilar codigo DRY
  before_action :set_article, except: [:index, :new, :create]
  #GET /articles
  def index
    @articles = Article.all

  end
  #GET /article/:id
  def show
     @article.update_visits_count 
   end
  #GET /article/new
  def new
    @article = Article.new
  end

  #GET /article/:id/edit
  def edit
    
  end

 #POST /articles
  def create
    @article = current_user.articles.new(article_params)
      if @article.save
      redirect_to  @article 
      else
      render :new
    end 
  end

  def destroy
   
    @article.destroy  
    redirect_to articles_path
  end

  def update
    
    if @article.update(article_params)
      redirect_to @article
      else
        render :edit
  end
end


  private
  #para validar sessiones 
  # def validate_user
  #   redirect_to new_user_session_path, notice: "Tienes que iniciar session "
  # end
  def set_article
    @article = Article.find(params[:id])
  end
   def article_params
     params.require(:article).permit(:title, :body)
   end
end