visiting
visitSelectQuery: aQuery with: aStream
	aQuery columnsDo: [ :column |
		self visit: column with: aStream ].
	
	aQuery joinsDo: [ :join |
		self visit: join with: aStream ].
	
	self visit: aQuery condition with: aStream.
	self visit: aQuery grouping with: aStream.
	self visit: aQuery ordering with: aStream