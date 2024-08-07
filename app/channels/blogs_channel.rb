class BlogsChannel < ApplicationCable::Channel
  def subscribed
    blog = Blog.find(params[:id])
    stream_for blog
  end
end
