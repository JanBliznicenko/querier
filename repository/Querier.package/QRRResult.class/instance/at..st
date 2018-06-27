api
at: primaryKey
	executed ifFalse: [
		^ self fetchOneByPrimaryKey: primaryKey ].
	
	self execute.
	
	^ rows at: primaryKey