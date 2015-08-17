require "./lib/tf-idf/tf_idf.rb"
class PostsController < ApplicationController

  def index
    @posts =  Post.order(updated_at: :desc).take(12)
  end

  def show
    @post = Post.find(params[:id])
    @tags_hash = @post.tags_and_scores_hash
    @extracted_terms = @post.extracted_terms
  end

  def search
    @posts_and_scores_hash = Hash.new
    @posts_and_tags_hash = Hash.new
    search_tokens = params[:search].split(" ")
    @tags = Tag.where(tag: search_tokens).uniq
    if @tags.present?
      @tags.each do |tag|
        @posts_tags = @posts_tags ? @posts_tags + PostsTag.where(tag_id: tag.id) : PostsTag.where(tag_id: tag.id)
      end
      @posts_tags.each do |posts_tag|
        @posts_and_scores_hash[posts_tag.post] = posts_tag.post.search_score(@posts_tags) #[post => score]
        @posts_and_tags_hash[posts_tag.post] = posts_tag.post.search_tags_and_scores_hash(@posts_tags) #[post => [tag => score]]
      end
      @posts_and_scores_hash = @posts_and_scores_hash.sort_by {|post, score| score}
    end
  end
end
