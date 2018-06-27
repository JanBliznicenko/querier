api - ordering
orderAscendinglyBy: aSymbolOrBlock
	query ordering addAscendingColumn: (self createOrderColumnFrom: aSymbolOrBlock)