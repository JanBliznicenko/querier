visiting
visitInsertQuery: aQuery with: aStream
	aQuery columnsDo: [ :column |
		self visit: column with: aStream ].
	
	aQuery valuesDo: [ :value |
		self visit: value with: aStream ]