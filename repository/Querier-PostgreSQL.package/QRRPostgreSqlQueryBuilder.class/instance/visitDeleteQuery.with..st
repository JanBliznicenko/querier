visiting - queries
visitDeleteQuery: aQuery with: aStream
	aStream singleTableQuery: true.
	
	aStream
		nextPutAll: 'DELETE FROM ';
		nextPutAll: (self escapeIdentifier: aQuery table).
	
	self visitWhereCondition: aQuery condition with: aStream