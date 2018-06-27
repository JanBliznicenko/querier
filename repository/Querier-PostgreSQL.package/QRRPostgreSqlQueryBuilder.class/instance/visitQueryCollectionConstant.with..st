visiting - expressions
visitQueryCollectionConstant: aQueryConstant with: aStream
	aStream nextPut: $(.
	
	aQueryConstant value
		do: [ :each |
			self visit: each with: aStream ]
		separatedBy: [
			aStream nextPutAll: ', ' ].
	
	aStream nextPut: $)