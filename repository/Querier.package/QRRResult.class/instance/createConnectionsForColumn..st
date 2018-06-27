private - connected tables
createConnectionsForColumn: aColumn
	| identifierCount |
	
	identifierCount := aColumn qrrGetIdentifiers size.
	
