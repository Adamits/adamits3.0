# This is a document of the collection
# That is checked to calculate an idf score.

include TfIdf
class TfIdf::Document < TfIdf::Collection
	attr_reader :tokens

	def initialize(document)
		@document = document
		@tokens = tokenize
	end

	private
	def tokenize
		tokens = @document.gsub(/[^a-zA-Z0-9 - ' _]/, "").downcase
		return tokens.split(' ')
	end
end