api - modifications
delete
	executed
		ifTrue: [ ^ self deleteAllRowsFromResult ]
		ifFalse: [ ^ self deleteWithCondition: query condition ]