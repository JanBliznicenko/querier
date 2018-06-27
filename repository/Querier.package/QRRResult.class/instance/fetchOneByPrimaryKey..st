api
fetchOneByPrimaryKey: primaryKey
	| result |
	
	result := querier table: self table.
	result limit: 1.
	
	primaryKeyColumn
		ifNotNil: [ result select: {primaryKeyColumn -> primaryKey} ]
		ifNil: [ result offset: primaryKey - 1 ].
	
	^ result fetchOne