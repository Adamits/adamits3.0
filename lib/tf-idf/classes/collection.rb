include TfIdf
class TfIdf::Collection 
	# @idf_hash- A hash of terms and their idf scores
	# @quantity- The amount of sub_docs in the collection
	#
	# This loops through all the terms from the tf_hash
	# parameter to calculace document frequency
	# The rest of the idf calculation is done in a seperate
	# Loop so that the Math does not need to run 
	# collection.quantity X terms_doc.quantity times. 
	attr_reader :idf_hash, :collection, :quantity

	def initialize(collection, tf_hash)
		@idf_hash = Hash.new(0.0)
		@collection = collection
		@tf_hash = tf_hash
	end

	# Loop through terms from tf_hash
	# And find the document frequency of each term
	def get_idf_hash
		# Tokenize every document in the collection
		@sub_docs = tokenize_documents
		@quantity = @collection.length
		@tf_hash.each do |term, tf|
			@sub_docs.each do |doc|
				if doc.include?(term)
					# Increment document frequency.
					@idf_hash[term] += 1.0
				end
			end
		end
		return @idf_hash
	end

	private
	# Returns a 2D array of all documents in the collection
	# And all tokens of the documents
	def tokenize_documents
		# An array to store all tokenized documents
		@documents = Array.new
		@collection.each do |document|
			# An object of the sub-document in the collection
			@document = TfIdf::Document.new(document)
			# Add each document to the documents array
			@documents.push(@document.tokens)
		end
		return @documents
	end
end