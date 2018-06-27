api - enumerating
fetchOne
	| primaryKey |
	
	self execute.
	
	primaryKey := rows keyAtIndex: position ifAbsent: [ ^ nil ].
	
	position := position + 1.
	
	^ rows at: primaryKey