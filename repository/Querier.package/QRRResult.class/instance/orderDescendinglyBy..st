api - ordering
orderDescendinglyBy: aSymbolOrBlock
	query ordering addDescendingColumn: (self createOrderColumnFrom: aSymbolOrBlock)