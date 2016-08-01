class PostsController < ApplicationController
  def index
    @posts = Post.all.reverse
    @upcomingposts = Post.where("date >= ?", Date.today)
    @date = params[:month] ? Date.parse(params[:month].gsub('-', '/')) : Date.today
  end

  def upcoming
    @posts = Post.where("date >= ?", Date.today).reverse
  end

  def past
    @posts = Post.where("date <= ?", Date.today).reverse
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    render :"posts/new"
  end

  def create
    @post = Post.new(post_params)
    @post.document = params[:post][:document]
    if @post.save
      if params[:images]
        params[:images].each { |image|
          @post.pictures.create(image: image)
        }
      end
      redirect_to :root
    else
      render :"posts/new"
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if params[:post][:document]
      @post.document = params[:post][:document]
    end
    if @post.update(post_params)
      if params[:images]
        @post.pictures.destroy_all
        params[:images].each { |image|
          @post.pictures.create(image: image)
        }
      end
      redirect_to :root
    else
      render :"post/edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to :root
  end
  
  private

  def post_params
    params.require(:post).permit(:title, :description, :date)
  end
end
