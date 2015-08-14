# This is the document whose terms are being weighted.
# tf_hash: A hash of all valid terms => their term frequency
#
# tf_hash is an attribute of the TermsDocument, because all terms
# Of the document must be parsed in order to have an accurate tf.
require TfIdf
class TfIdf::TermsDocument
	attr_reader :tf_hash, :tokens, :term, :quantity, :content

	def initialize(content)
		@content = content
	end

	def get_terms_and_tf_scores
		@tf_hash = Hash.new(0.0)
		# The amount of times a term appears
		# In the document divided by the total
		# Amount of tokens in the document.
		@tokens = tokenize
		@quantity = @tokens.length
		@tokens.each do |term|
			# Set term to accessible attr so
			# private Method can check it.
			@term = term
			if is_valid_term
				@tf_hash[@term] += 1.0
			end
		end
		return @tf_hash
	end

	private
	def tokenize
		tokens = @content.gsub(/[^a-zA-Z0-9 - ' _]/, "").downcase
		return tokens.split(' ')
	end

	def is_valid_term
		return true
	end
end
