require "./lib/tf-idf/tf_idf.rb"
class Admin::PostsController < ApplicationController
  before_filter :authorize

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @tag_post = [@post]
    if @post.save
      @tags_object = TfIdf::WeightedTags.new(all_posts, @post.content)
      @tags_object.get_weighted_tags.each do |tag, term_score|
        @tag = Tag.new(:tag => tag)
        @tag.posts = @tag_post
        @tag.term_score = term_score
        @tag.save
      end
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
      @post.tags.each {|tag| tag.delete}
      @tags_object = TfIdf::WeightedTags.new(all_posts, @post.content)
      @tags_object.get_weighted_tags.each do |tag, term_score|
        @tag = Tag.new(:tag => tag)
        @tag.posts = @tag_post
        @tag.term_score = term_score
        @tag.save
      end
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
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

  def all_posts
    all_posts = Array.new
    post_objects = Post.all
    post_objects.each do |post|
      all_posts << post.content
    end
    return all_posts
  end
end