expression building
at: key put: value
	| column valueExpression |
	
	column := self class identifiers: (identifiers copyWith: key).
	valueExpression := value asQuerierExpression.
	
	QRRModificationNotification signalForColumn: column value: valueExpression.
	
	^ QRRQueryAssignmentOperation
			left: column
			right: valueExpression