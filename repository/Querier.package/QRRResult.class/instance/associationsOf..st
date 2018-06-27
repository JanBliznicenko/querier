api - enumerating
associationsOf: aColumn
	self execute.
	
	^ Array new: self size streamContents: [ :stream |
			self associationsDo: [ :each |
				stream nextPut: each key -> (aColumn value: each value) ] ]