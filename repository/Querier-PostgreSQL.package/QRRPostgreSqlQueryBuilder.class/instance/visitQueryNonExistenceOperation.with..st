visiting - operations
visitQueryNonExistenceOperation: aQueryOperation with: aStream
	self
		parenthesized: [
			aStream nextPutAll: ' NOT EXISTS '.
			
			self visit: aQueryOperation rightExpression with: aStream ]
		on: aStream