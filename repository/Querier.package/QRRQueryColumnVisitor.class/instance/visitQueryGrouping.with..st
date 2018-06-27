visiting
visitQueryGrouping: aQueryGrouping with: aStream
	aQueryGrouping columnsDo: [ :each |
		self visit: each with: aStream ].
	
	self visit: aQueryGrouping condition with: aStream