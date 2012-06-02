class Tagfld 
  # A tagfld is the concatenation of all the tags for a given item.
	attr_reader :mytext
	
	def initialize 
		@mytext = ''	
	end
	
	def add_atag(label)
		if self.isempty 
			@mytext = label
		else 	
			if mytext.nil?
				@mytext = label
			else
				@mytext << " " + label
			end
		end
	end
	
	def empty! 
		@mytext = ''
	end
	
	def isempty
		if @mytext == ''
			true
		else
			false
		end
	end
	
end