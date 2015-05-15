require "./lib/tf-idf/tf_idf.rb"
class PostsController < ApplicationController
  def index
    @posts =  Post.last(9)
  end

  def show
    @post = Post.find(params[:id])
    tags_hash = Hash.new
    @post.tags.each do |tag|
      tags_hash[tag.tag] = tag.term_score
    end
    @tags_hash = tags_hash.sort_by {|key, value| value}
    @tags_hash.reverse!
    @extracted_terms = Array.new
    @tags_hash.first(10).each do |array|
      tag = array[0]
      @extracted_terms.append tag
    end
  end

  private
  def all_posts
  all_posts = Array.new
  post_objects = Post.all
  post_objects.each do |post|
    all_posts << post.content
  end
    return all_posts
  end
end