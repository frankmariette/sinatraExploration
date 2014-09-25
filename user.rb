class User
	def initialize(id=nil)
		if id
			@user = Person.find(id)
		else
			redirect to('index')
		end
	end
end