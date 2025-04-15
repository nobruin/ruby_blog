class BlogPostsController < ApplicationController
  def index
    @blog_posts = BlogPost.all
  end

  def show
    @blog_post = BlogPost.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Blog post not found."
    redirect_to root_path
  rescue StandardError => e
    flash[:alert] = "An error occurred: #{e.message}"
    redirect_to root_path
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

  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :body)
  end
end
