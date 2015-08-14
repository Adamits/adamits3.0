class Admin::PostsController < ApplicationController
  before_filter :authorize

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      @post.get_weighted_tags
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @tag_post = [@post]
    if @post.update_attributes(post_params)
      if @post.delete_all_tags_and_posts_tags
        @post.get_weighted_tags
        redirect_to post_path(@post)
      else
        render :edit
      end
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.posts_tags.each do |posts_tag|
      posts_tag.destroy
    end
    @post.destroy
    redirect_to root_path
  end

  def update_all
    @posts = Post.all
    @posts.each do |post|
      post.get_weighted_tags
    end
    redirect_to root_path
  end

  private
  def authorize
    unless current_user.admin?
      render "devise/sessions/new"
    end
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
