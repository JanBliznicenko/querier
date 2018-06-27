api
execute
	| queryResult |
	
	executed ifTrue: [ ^ self ].
	executed := true.
	
	rows := OrderedDictionary new.
	entityClass
		ifNotNil: [ rowEntities := nil ]
		ifNil: [ rowEntities := rows ].
	self resetPosition.
	
	queryResult := querier executeQuery: query.
	self flag: #todo. "handle exceptions"
	
	queryResult rowsDo: [ :rowDict |
		| primaryKey |
		primaryKey := (self primaryKeyForRow: rowDict) ifNil: [ rows size + 1 ].
		
		rows at: primaryKey put: (self createExistingRowFor: rowDict) ].
	
	columns := queryResult columns.
	
	self queryExecuted