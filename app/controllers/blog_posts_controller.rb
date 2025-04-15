class BlogPostsController < ApplicationController
  before_action :set_blog_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @blog_posts = BlogPost.all
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)
    if @blog_post.save
      flash[:notice] = "Blog post created successfully."
      redirect_to @blog_post
    else
      flash.now[:alert] = "Error creating blog post."
      render :new, status: :unprocessable_entity
    end
  end

  
  def show
  end  
  
  def edit
  end

  def update
    if @blog_post.update(blog_post_params)
      flash[:notice] = "Blog post updated successfully."
      redirect_to @blog_post
    else
      flash.now[:alert] = "Error updating blog post."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @blog_post.destroy
      flash[:notice] = "Blog post deleted successfully."
      redirect_to blog_posts_path
    else
      flash[:alert] = "Error deleting blog post."
      redirect_to @blog_post
    end 
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :body)
  end

  private
  def set_blog_post
    @blog_post = BlogPost.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Blog post not found."
    redirect_to root_path
  rescue StandardError => e
    flash[:alert] = "An error occurred: #{e.message}"
    redirect_to root_path
  end

  def authenticate_user!    
      flash[:alert] = "You must be signed in to access this section."
      redirect_to new_user_session_path, alert => "You must be signed in to access this section."
  end
end
