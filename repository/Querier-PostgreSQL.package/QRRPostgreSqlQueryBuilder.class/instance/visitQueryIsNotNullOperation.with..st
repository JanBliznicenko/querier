visiting - operations
visitQueryIsNotNullOperation: aQueryOperation with: aStream
	self visit: aQueryOperation expression with: aStream.
	aStream nextPutAll: ' IS NOT NULL '