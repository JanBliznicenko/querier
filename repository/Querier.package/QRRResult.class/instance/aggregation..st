api - aggregations
aggregation: aString
	^ self executeAggregation: (QRRQueryLiteral with: aString)