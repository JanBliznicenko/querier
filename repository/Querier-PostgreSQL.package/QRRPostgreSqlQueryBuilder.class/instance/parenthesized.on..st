private
parenthesized: aBlock on: aStream
	aStream nextPut: $(.
	aBlock value.
	aStream nextPut: $)