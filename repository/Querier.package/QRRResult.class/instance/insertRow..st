modifications
insertRow: aRow
	| insertQuery queryResult |
	
	self flag: #todo.
	"if insert fails on duplicate key, issue a save (UPDATE)?"
	
	self flag: #todo. "transform referenced and referencing rows to ID assignments to *_id"
	
	insertQuery := QRRInsertQuery new table: self table.
	insertQuery addColumnsAndValues: (aRow asDictionary associations collect: [ :each | (self createTableColumn: each key) -> each value asQuerierExpression ]).
	insertQuery returnRow: true.
	
	queryResult := querier executeQuery: insertQuery.
	
	self flag: #todo.
	"queryResult rowsDo: [ :rowDict |
		aRow result: self values: rowDict exists: true.
		^ 1 ].
	^ 0"
	
	^ queryResult affectedRows