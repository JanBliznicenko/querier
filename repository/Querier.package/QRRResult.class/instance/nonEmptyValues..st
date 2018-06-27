api - enumerating
nonEmptyValues: aSymbolOrBlock
	self execute.
	
	^ Array new: self size streamContents: [ :stream |
			self do: [ :each |
				| value |
				value := aSymbolOrBlock value: each.
				value ifNotNil: [ stream nextPut: value ] ] ]