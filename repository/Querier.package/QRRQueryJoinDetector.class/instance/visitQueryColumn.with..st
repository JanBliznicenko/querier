visiting
visitQueryColumn: aQueryColumn with: aStream
	aQueryColumn ifMoreThan: 2 identifiersDo: [
		aStream nextPut: aQueryColumn ]