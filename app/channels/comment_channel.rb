class CommentChannel < ApplicationCable::Channel
  def subscribed
    @blog = Blog.find(params[:id])
    stream_for @blog
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    comment = @blog.comments.create!(content: data['content'], user: current_user)
    CommentChannel.broadcast_to(@blog, comment: comment)
  end
end
