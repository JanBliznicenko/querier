visiting - functions
visitQueryFunction: aQueryFunction with: aStream
	aStream nextPutAll: (self functionName: aQueryFunction functionName) asUppercase.
	
	aStream nextPut: $(.
	
	aQueryFunction
		expressionsDo: [ :each |
			self visit: each with: aStream ]
		separatedBy: [
			aStream nextPutAll: ', ' ].
	
	aStream nextPut: $)