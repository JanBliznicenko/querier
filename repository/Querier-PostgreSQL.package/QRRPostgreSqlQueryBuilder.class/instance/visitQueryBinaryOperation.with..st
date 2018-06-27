visiting - operations
visitQueryBinaryOperation: aQueryOperation with: aStream
	self
		parenthesized: [
			self visitQueryBinaryOperationWithoutParentheses: aQueryOperation with: aStream ]
		on: aStream