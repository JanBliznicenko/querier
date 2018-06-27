enumerating
rowsDo: aBlock
	columns := driver execute: queryString rowsDo: aBlock