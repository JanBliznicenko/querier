modifications
deleteRow: aRow
	| condition |
	
	self flag: #todo. "raise exception"
	primaryKeyColumn ifNil: [ ^ 0 ].
	
	condition :=
		(QRRQueryEqualComparison
			left: (self createTableColumn: primaryKeyColumn)
			right: (aRow at: primaryKeyColumn) asQuerierExpression).
	
	^ self deleteWithCondition: condition