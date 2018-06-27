api - index access
atIndex: anInteger
	| primaryKey |
	
	self execute.
	
	self flag: #todo. "throw an exception"
	primaryKey := rows keyAtIndex: anInteger ifAbsent: [ ^ nil ].
	
	^ rows at: primaryKey