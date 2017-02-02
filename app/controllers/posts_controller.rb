class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @posts = Post.all
    @month_posts = @posts.where("date >= ? AND date <= ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month )
    @posts = @posts.sort {|x, y| x.date <=> y.date}
    @month_posts = @month_posts.sort {|x, y| x.date <=> y.date}
    @date = params[:month] ? Date.parse(params[:month].gsub('-', '/')) : Date.today
  end

  def upcoming
    @posts = Post.where("date >= ?", Date.today)
    @posts = @posts.sort {|x, y| x.date <=> y.date}
  end

  def past
    @posts = Post.where("date <= ?", Date.today)
    @posts = @posts.sort {|x, y| y.date <=> x.date}
  end

  def show
    @post = Post.find(params[:id])
    @pictures = @post.pictures
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
      @errors = @post.errors.full_messages
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
      @errors = @post.errors.full_messages
      render :"post/edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to :root
  end

  private
  def logged_in?
    session[:user_id] != nil
  end

  def authenticate_user!
    redirect_to root_path unless logged_in?
  end

  def post_params
    params.require(:post).permit(:title, :description, :date)
  end
end
