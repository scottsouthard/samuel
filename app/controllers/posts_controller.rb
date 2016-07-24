class PostsController < ApplicationController
  def index
    @posts = Post.all.reverse
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

  private

  def post_params
    params.require(:post).permit(:title, :description, :date)
  end
end
