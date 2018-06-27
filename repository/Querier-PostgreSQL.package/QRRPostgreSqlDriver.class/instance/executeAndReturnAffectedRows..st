lazy execution
executeAndReturnAffectedRows: queryString
	| result |
	
	self ensureConnection.
	
	result := connection execute: queryString.
	
	result errorResponse ifNotNil: [ :error |
		QRRPostgreSqlError signal: error value ].
	
	result lastResultSet
		ifNil: [ QRRPostgreSqlError signal: 'No result set.' ]
		ifNotNil: [ ^ result lastResultSet completedResponse value asInteger ]