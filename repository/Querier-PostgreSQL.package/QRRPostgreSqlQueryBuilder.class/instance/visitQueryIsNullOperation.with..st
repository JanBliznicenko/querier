visiting - operations
visitQueryIsNullOperation: aQueryOperation with: aStream
	self visit: aQueryOperation expression with: aStream.
	aStream nextPutAll: 'IS NULL '