visiting - conditions
visitCondition: aCondition precededBy: aString with: aStream
	aCondition isEmpty ifTrue: [ ^ self ].
	
	aStream nextPutAll: aString.
	self visit: aCondition with: aStream