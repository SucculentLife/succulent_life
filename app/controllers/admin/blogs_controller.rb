class Admin::BlogsController < ApplicationController
  def new
    @blog = Blog.new
  end
  
  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      if params[:blog][:images].present?
        params[:blog][:images].each do |image|
          @blog.blog_images.create(image: image, blog_id: @blog.id)
        end
      end
      redirect_to admin_blog_path(@blog.id)
    else
      render :new
    end
  end
  
  def index
    @blogs = Blog.page(params[:page]).per(10)
  end
  
  def show
    @blog = Blog.find(params[:id])
    @blog_images = @blog.blog_images
  end
  
  def edit
    @blog = Blog.find(params[:id])
    @blog_images = @blog.blog_images
  end
  
  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      if params[:blog][:images].present?
        @blog.blog_images.delete_all
        params[:blog][:images].each do |image|
          @blog.blog_images.create(image: image, blog_id: @blog.id)
        end
      end
      redirect_to admin_blog_path(params[:id])
    else
      render :edit
    end
  end
  
  def destroy
    blog = Blog.find(params[:id])
    blog.destroy
    redirect_to admin_blogs_path
  end
  
  private
   def blog_params
     params.require(:blog).permit(:title, :body, blog_images_attributes: [:image])
   end
end
