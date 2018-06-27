api - aggregations
countDistinct: aSymbolOrBlock
	^ self
			aggregation: QRRQueryCountFunction
			column: [ :column |
				QRRQueryDistinctOperation
					expression: (aSymbolOrBlock value: column) ]