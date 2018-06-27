visiting - queries
visitInsertQuery: aQuery with: aStream
	aStream singleTableQuery: true.
	
	aStream
		nextPutAll: 'INSERT INTO ';
		nextPutAll: (self escapeIdentifier: aQuery table);
		nextPutAll: ' ('.
	
	aQuery
		columnsDo: [ :column |
			self visit: column with: aStream ]
		separatedBy: [
			aStream nextPutAll: ', ' ].
	
	aStream
		nextPutAll: ')';
		cr;
		nextPutAll: 'VALUES ('.
	
	aQuery
		valuesDo: [ :value |
			self visit: value with: aStream ]
		separatedBy: [
			aStream nextPutAll: ', ' ].
	
	aStream nextPutAll: ')'.
	
	aQuery returnRow ifTrue: [
		aStream
			cr;
			nextPutAll: 'RETURNING *' ]