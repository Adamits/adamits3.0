# This is a document of the collection
# That is checked to calculate an idf score.

require './collection.rb'
class Document < Collection
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
