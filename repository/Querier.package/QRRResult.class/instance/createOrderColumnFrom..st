private - ordering
createOrderColumnFrom: aSymbolOrBlock
	| column |
	
	column := aSymbolOrBlock value: self createTableColumn.
	self createJoinsForColumn: column.
	
	^ column