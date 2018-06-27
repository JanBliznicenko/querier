api - ordering
sorted: aBlock
	"Example:
		aResult sorted: [ :a :b | a date < b date ]
	Currently, this is limited to one expression in the form of the previous example, no combinations (#& or #and:)."
	| comparison column |
	
	comparison := aBlock value: self createTableColumn value: self createTableColumn.
	column := comparison leftExpression.
	self createJoinsForColumn: column.
	
	(#(#> #>=) includes: comparison operatorSymbol)
		ifTrue: [ query ordering addDescendingColumn: column ]
		ifFalse: [ query ordering addAscendingColumn: column ]