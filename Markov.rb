class MarkovChain
	attr_accessor :table, :text

	def initialize(text)
		@text = text.split(" ")
		@table = {}
		genTable
	end

	def genTable
		prev = ""
		text.each do |word|
			if !prev.empty?
				key = prev
				if @table.has_key?(key)
					table[key] << word
				else
					table[key] = [word]
				end
			end
			prev = word
		end
	end

	def genText(numOfWords)
		word = @text[0]
		result = [word]
		numOfWords.times do |i|
			key = word
			if @table.has_key?(key)
				nextWord = random_word(@table[key])
				result << nextWord
			end
			word = nextWord
		end

		result.join(" ")
	end

	def random_word(array)
		array[rand(array.size)]
	end
end

text = File.read(ARGV[0])
chain = MarkovChain.new(text)
puts chain.genText(ARGV[1].to_i)
