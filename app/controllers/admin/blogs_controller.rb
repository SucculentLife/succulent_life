class Admin::BlogsController < ApplicationController
  def new
    @blog = Blog.new
  end
  
  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      if params[:blog][:blogs].present?
        params[:blog][:blogs].each do |blog|
          @blog.photos.create(image: image, blog_id: @blog.id)
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
    # @photos = @blog.photos
    @i = 0
  end
  
  def edit
    @blog = Blog.find(params[:id])
    @photos = @blog.photos
  end
  
  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      if params[:blog][:blogs].present?
        @blog.photos.delete_all
        params[:item][:items].each do |image|
          @blog.photos.create(image: image, blog_id: @blog.id)
        end
      end
      redirect_to admin_blog_path(parems[:id])
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
     params.require(:blog).permit(:title, :body, photos_attributes: [:image])
   end
end
