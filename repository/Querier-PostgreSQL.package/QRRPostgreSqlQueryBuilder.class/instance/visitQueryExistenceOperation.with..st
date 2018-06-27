visiting - operations
visitQueryExistenceOperation: aQueryOperation with: aStream
	self
		parenthesized: [
			aStream nextPutAll: ' EXISTS '.
			
			self visit: aQueryOperation rightExpression with: aStream ]
		on: aStream