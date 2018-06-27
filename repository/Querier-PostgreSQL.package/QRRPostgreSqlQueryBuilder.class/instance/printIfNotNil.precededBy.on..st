private
printIfNotNil: anObject precededBy: aString on: aStream
	anObject ifNil: [ ^ self ].
	
	aStream
		nextPutAll: aString;
		nextPutAll: anObject printString