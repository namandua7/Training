class RepliesController < ApplicationController
    def new
        @blog = Blog.find(params[:blog_id])
        @comment = @blog.comments.find(params[:comment_id])
        @reply = @comment.replies.build
    end
end
