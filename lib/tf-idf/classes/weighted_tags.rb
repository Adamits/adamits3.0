# This is the public object that should be used in the website.
#
# Takes two params:
#
# document- the document to extract tags from.
# collection- the corpus of other documents to compare it to.
require TfIdf
class TfIdf::WeightedTags
	attr_reader :tf_idf_hash
	def initialize(collection, document)
		@collection_docs = collection
		@term_doc_string = document
		@tf_idf_hash = Hash.new(0.0)
	end

	def get_weighted_tags
		@term_doc = TfIdf::TermsDocument.new(@term_doc_string)
		@tf_hash = get_termsDoc_hash
		# Instantiate collection
		@collection = TfIdf::Collection.new(@collection_docs, @tf_hash)
		@idf_hash = get_collection_hash
		# Loop through all terms to finish calculations
		# On tf and idf, and finally get the tf_idf score
		@doc_size = @term_doc.quantity
		@collection_size = @collection.quantity
		@tf_hash.each do |term, tf|
			@idf_hash[term] = 1 if @idf_hash[term] == 0
			@tf = tf / @doc_size
			@idf = Math.log(@collection_size / @idf_hash[term])
			@tf_idf_hash[term] = @tf * @idf
		end
		return @tf_idf_hash
	end

	private
	def get_termsDoc_hash
		return @term_doc.get_terms_and_tf_scores
	end

	def get_collection_hash
		return @collection.get_idf_hash
	end
end
