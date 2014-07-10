class MapsController < ApplicationController
  def show
    # raise "hello"
    @post = Post.find params[:post_id]
  end
end
