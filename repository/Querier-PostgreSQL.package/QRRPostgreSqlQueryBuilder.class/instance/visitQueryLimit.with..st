visiting - query parts
visitQueryLimit: aQueryLimit with: aStream
	self printIfNotNil: aQueryLimit limit
		precededBy: String cr , 'LIMIT '
		on: aStream.
	
	self printIfNotNil: aQueryLimit offset
		precededBy: String cr , ' OFFSET '
		on: aStream