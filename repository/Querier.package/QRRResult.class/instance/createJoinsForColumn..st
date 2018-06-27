private - joins
createJoinsForColumn: aQueryColumn
	| identifiers finalJoinAlias |
	
	identifiers := aQueryColumn qrrGetIdentifiers.
	
	2 to: identifiers size - 1 do: [ :count |
		self createJoinForTables: (identifiers first: count) ].
	
	finalJoinAlias := (usedTables at: identifiers allButLast) alias.
	
	aQueryColumn qrrSetIdentifiers: (Array with: finalJoinAlias with: identifiers last)