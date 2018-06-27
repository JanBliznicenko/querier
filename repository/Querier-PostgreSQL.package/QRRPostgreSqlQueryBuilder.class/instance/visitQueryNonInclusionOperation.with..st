visiting - operations
visitQueryNonInclusionOperation: aQueryOperation with: aStream
	self
		parenthesized: [
			self visit: aQueryOperation leftExpression with: aStream.
			
			aStream nextPutAll: ' NOT IN '.
			
			self visit: aQueryOperation rightExpression with: aStream ]
		on: aStream