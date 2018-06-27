modifications
saveRow: aRow withColumns: aCollection
	| updateQuery condition queryResult |
	
	self flag: #todo. "raise exception"
	primaryKeyColumn ifNil: [ ^ 0 ].
	
	updateQuery := QRRUpdateQuery new table: self table.
	
	condition :=
		(QRRQueryEqualComparison
			left: (self createTableColumn: primaryKeyColumn)
			right: (aRow at: primaryKeyColumn) asQuerierExpression).
	
	updateQuery addCondition: condition.
	
	aCollection do: [ :each |
		updateQuery addColumn: (self createTableColumn: each) value: (aRow at: each) ].
	
	queryResult := querier executeQuery: updateQuery.
	
	^ queryResult affectedRows