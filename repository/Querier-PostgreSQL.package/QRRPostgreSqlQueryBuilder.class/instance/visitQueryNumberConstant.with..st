visiting - expressions
visitQueryNumberConstant: aQueryConstant with: aStream
	aStream nextPutAll: (self numberConstantFor: aQueryConstant value)