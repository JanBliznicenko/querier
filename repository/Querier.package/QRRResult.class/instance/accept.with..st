visiting
accept: aVisitor with: anObject
	self flag: #todo. "only SELECT {primaryKey}"
	^ aVisitor visit: query with: anObject