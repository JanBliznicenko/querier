private - aggregations
aggregation: aFunctionClass column: aSymbolOrBlock
	| column |
	
	column := aFunctionClass expression: (aSymbolOrBlock value: self createTableColumn).
	
	^ self executeAggregation: column