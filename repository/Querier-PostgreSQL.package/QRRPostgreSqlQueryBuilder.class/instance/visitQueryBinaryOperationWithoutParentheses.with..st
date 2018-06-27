visiting - operations
visitQueryBinaryOperationWithoutParentheses: aQueryOperation with: aStream
	self visit: aQueryOperation leftExpression with: aStream.
	
	aStream
		space;
		nextPutAll:
			('NULL' = aQueryOperation rightExpression value
				ifTrue: [
					aQueryOperation operatorSymbol = #~=
						ifTrue: [ 'IS NOT' ]
						ifFalse: [ 'IS' ] ]
				ifFalse: [
					self binaryOperationSymbol: aQueryOperation operatorSymbol ]);
		space.
	
	self visit: aQueryOperation rightExpression with: aStream