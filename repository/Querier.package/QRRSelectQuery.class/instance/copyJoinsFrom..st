copying
copyJoinsFrom: aQuery
	aQuery joinsDo: [ :each |
		self addJoin: each ]