visiting
visitQueryBinaryOperation: aQueryOperation with: aStream
	self visit: aQueryOperation leftExpression with: aStream.
	self visit: aQueryOperation rightExpression with: aStream