visiting - queries
visitUpdateQuery: aQuery with: aStream
	aStream singleTableQuery: true.
	
	aStream
		nextPutAll: 'UPDATE ';
		nextPutAll: (self escapeIdentifier: aQuery table);
		cr;
		nextPutAll: 'SET '.
	
	aQuery
		columnsAndValuesDo: [ :column :value |
			self visit: column with: aStream.
			aStream	 nextPutAll: ' = '.
			self visit: value with: aStream ]
		separatedBy: [
			aStream nextPutAll: ', ' ].
	
	self visitWhereCondition: aQuery condition with: aStream