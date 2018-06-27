visiting - expressions
visitQuerySimpleColumn: aQueryConstant with: aStream
	(aQueryConstant identifiers collect: [ :each | self escapeIdentifier: each ])
		printOn: aStream
		delimiter: '.'