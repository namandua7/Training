class BlogsController < ApplicationController
  def index
    @blogs = Blog.all.paginate(page: params[:page], per_page: 9)
  end
  def search
    @blog_search = Blog.ransack(params[:q])
    @query = @blog_search.result(distinct: true).paginate(page: params[:page], per_page: 9)
  end
  def new
    @blog = Blog.new
  end
  def create
    @user = current_user
    @blog = @user.blogs.new(blog_params)
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
    @comment = @blog.comments.where(parent_id: nil).order(created_at: :desc)
  end
  private
  def blog_params
    params.require(:blog).permit(:title, :description)
  end
end