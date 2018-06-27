visiting - operations
visitQueryInclusionOperation: aQueryOperation with: aStream
	self
		parenthesized: [
			self visit: aQueryOperation leftExpression with: aStream.
			
			aStream nextPutAll: ' IN '.
			
			self visit: aQueryOperation rightExpression with: aStream ]
		on: aStream