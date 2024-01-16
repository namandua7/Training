class CommentsController < ApplicationController
    def new
        @blog = Blog.find(params[:blog_id])
        @comment = @blog.comments.build
    end
    def create
        @blog = Blog.find(params[:blog_id])
        @comment = @blog.comments.new(comment_params)
        if @comment.save
          redirect_to @blog
        else
          redirect_to @blog
        end
    end
    def destroy
        @blog = Blog.find(params[:blog_id])
        @comment = @blog.comments.find(params[:id])
        @comment.destroy
        redirect_to @blog
    end
    private
    def comment_params
        params.require(:comment).permit(:content)
    end
end
