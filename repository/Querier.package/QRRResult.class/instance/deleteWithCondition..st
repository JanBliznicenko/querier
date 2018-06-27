private - modifications
deleteWithCondition: aCondition
	| deleteQuery queryResult |
	
	deleteQuery := QRRDeleteQuery new table: self table.
	deleteQuery addCondition: aCondition.
	
	queryResult := querier executeQuery: deleteQuery.
	self flag: #todo. "handle exceptions"
	
	^ queryResult affectedRows