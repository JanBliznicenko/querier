api - aggregations
sum: aSymbolOrBlock
	^ self aggregation: QRRQuerySumFunction column: aSymbolOrBlock