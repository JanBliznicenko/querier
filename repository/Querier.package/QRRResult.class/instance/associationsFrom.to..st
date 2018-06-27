api - enumerating
associationsFrom: keyColumn to: valueColumn
	self columns: { keyColumn asString. valueColumn asString }.
	self execute.
	
	^ Array new: self size streamContents: [ :stream |
			self do: [ :each |
				stream nextPut: (keyColumn value: each) -> (valueColumn value: each) ] ]