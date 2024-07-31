class Public::BlogsController < ApplicationController
  def index
    @blogs = Blog.page(params[:page]).per(10)
  end
  
  def show
    @blog = Blog.find(params[:id])
    @blog_images = @blog.blog_images
  end
end
