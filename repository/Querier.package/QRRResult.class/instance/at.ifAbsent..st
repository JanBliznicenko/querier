api
at: primaryKey ifAbsent: aBlock
	executed ifFalse: [
		^ (self fetchOneByPrimaryKey: primaryKey) ifNil: aBlock ].
	
	self execute.
	
	^ rows at: primaryKey ifAbsent: aBlock