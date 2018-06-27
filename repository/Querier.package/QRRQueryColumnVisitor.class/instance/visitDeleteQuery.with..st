visiting
visitDeleteQuery: aQuery with: aStream
	aQuery joinsDo: [ :join |
		self visit: join with: aStream ].
	
	self visit: aQuery condition with: aStream