api - columns
columns: aCollection
	aCollection do: [ :each |
		query addColumn: (self createColumn: each) ]