visiting - expressions
visitQueryColumn: aQueryColumn with: aStream
	| hideFirst |
	
	hideFirst := aStream singleTableQuery.
	
	aQueryColumn
		identifiersDo: [ :identifier |
			hideFirst ifFalse: [
				aStream nextPutAll: (self escapeIdentifier: identifier) ] ]
		separatedBy: [
			hideFirst
				ifTrue: [ hideFirst := false ]
				ifFalse: [ aStream nextPut: $. ] ]