api - enumerating
values: aSymbolOrBlock
	self execute.
	
	^ Array new: self size streamContents: [ :stream |
			self do: [ :each |
				stream nextPut: (aSymbolOrBlock value: each) ] ]