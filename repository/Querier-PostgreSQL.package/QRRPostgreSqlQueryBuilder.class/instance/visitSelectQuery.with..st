visiting - queries
visitSelectQuery: aQuery with: aStream
	| hasColumns |
	
	aStream nextPutAll: 'SELECT '.
	
	hasColumns := false.
	aQuery
		columnsDo: [ :column |
			self visit: column with: aStream.
			hasColumns := true ]
		separatedBy: [
			aStream nextPutAll: ', ' ].
	
	hasColumns ifFalse: [ aStream nextPut: $* ].
	
	aStream
		cr;
		nextPutAll: 'FROM ';
		nextPutAll: (self escapeIdentifier: aQuery table).
	
	self visitQueryJoinsOf: aQuery with: aStream.
	
	self visitWhereCondition: aQuery condition with: aStream.
	
	self visit: aQuery grouping with: aStream.
	self visit: aQuery ordering with: aStream.
	self visit: aQuery limit with: aStream