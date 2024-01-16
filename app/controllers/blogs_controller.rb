class BlogsController < ApplicationController
  def index
    @blogs = Blog.all
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      redirect_to @blog
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to @blog
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @blog = Blog.find(params[:id])
    @comment = @blog.comments
    @comment.each do |comment|
    @reply = comment.replies
    end
  end
  private
  def blog_params
    params.require(:blog).permit(:title, :description)
  end
end
