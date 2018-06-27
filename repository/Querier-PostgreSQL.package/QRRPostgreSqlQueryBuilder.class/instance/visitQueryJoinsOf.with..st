visiting - query parts
visitQueryJoinsOf: aQuery with: aStream
	aQuery joinsDo: [ :join |
		self visit: join with: aStream ]