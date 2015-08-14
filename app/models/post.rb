require "./lib/tf-idf/tf_idf.rb"
class Post < ActiveRecord::Base
  belongs_to :user
  has_many :posts_tags
	has_many :tags, :through => :posts_tags
  validates_presence_of :title, :content

  def tags_hash
    tags_hash = Hash.new
    tags.each do |tag|
      post_tag = PostsTag.where(post_id: id, tag_id: tag.id)
      tags_hash[tag.tag] = post_tag.first.term_score
    end
    tags_hash = tags_hash.sort_by {|key, value| value}
    tags_hash.reverse!
  end

  def extracted_terms (tags_hash)
    extracted_terms = Array.new
    tags_hash.first(10).each do |array|
      tag = array[0]
      extracted_terms.append tag
    end
    extracted_terms
  end

  def get_weighted_tags
    @tags_object = TfIdf::WeightedTags.new(all_posts, "#{self.title} #{self.content}")
    @tags_object.get_weighted_tags.each do |tag, term_score|
      @tag = Tag.where(tag: tag).last || Tag.new(tag: tag)
      if @tag.save
        @posts_tag = self.posts_tags.where(tag: tag, post: self).last || self.posts_tags.create(tag_id: @tag.id, post_id: self.id)
        @posts_tag.term_score = term_score
        @posts_tag.save
      end
    end
  end

  def delete_all_tags_and_posts_tags
    success = true
    tags.each do |tag|
      unless PostsTag.where(tag_id: tag.id, post_id: id).last.destroy
        success = false
        break
      end
      unless tag.destroy
        success = false
        break
      end
    end
    return success
  end

  def search_score(posts_tags_from_search)
    score = 0
    posts_tags_from_search.each do |posts_tag_from_search|
      if posts_tag_from_search.post.id == id
        score += posts_tag_from_search.term_score
      end
    end
    score
  end

  def tags_and_scores_hash(posts_tags_from_search)
    tags_and_scores = Hash.new
    posts_tags_from_search.each do |posts_tag_from_search|
      if posts_tag_from_search.post.id == id
        tags_and_scores[posts_tag_from_search.tag.tag] = posts_tag_from_search.term_score
      end
    end
    tags_and_scores
  end

  private
  def all_posts
    all_posts = Array.new
    post_objects = Post.all
    post_objects.each do |post|
      all_posts << "#{post.title} #{post.content}"
    end
    return all_posts
  end
end
