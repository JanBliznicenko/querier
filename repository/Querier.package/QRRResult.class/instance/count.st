api
count
	self flag: #todo. "star is SQL-specific, refactor it to a class"
	executed
		ifTrue: [ ^ self size ]
		ifFalse: [ ^ self executeAggregation: (QRRQueryCountFunction expression: (QRRQueryLiteral with: '*')) ]