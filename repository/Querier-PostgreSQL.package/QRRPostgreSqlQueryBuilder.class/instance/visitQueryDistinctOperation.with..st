visiting - operations
visitQueryDistinctOperation: aQueryOperation with: aStream
	aStream nextPutAll: 'DISTINCT '.
	
	self visit: aQueryOperation expression with: aStream