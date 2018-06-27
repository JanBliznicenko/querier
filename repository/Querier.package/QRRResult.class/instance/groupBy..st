api - grouping
groupBy: aSymbolOrBlockOrCollection
	| groupColumns |
	
	groupColumns := aSymbolOrBlockOrCollection isCollection
		ifTrue: [ aSymbolOrBlockOrCollection collect: [ :each | self createTableColumn: each ] ]
		ifFalse: [ Array with: (aSymbolOrBlockOrCollection value: self createTableColumn) ].
	
	groupColumns do: [ :each |
		query grouping addColumn: each ]