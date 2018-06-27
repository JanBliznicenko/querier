visiting - expressions
visitQueryStringConstant: aQueryConstant with: aStream
	aStream nextPutAll: (self stringConstantFor: aQueryConstant value)