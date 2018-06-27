visiting - operations
visitQueryNotOperation: aQueryOperation with: aStream
	aStream nextPutAll: 'NOT '.
	self visit: aQueryOperation expression with: aStream