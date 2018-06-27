modifications
addNewRow: aDictionary
	| row |
	
	row := self createNewRowFor: aDictionary.
	
	^ rows at: 1 put: row