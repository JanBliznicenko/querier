private - joins
createJoinForTables: aCollection
	| usedSourceTable sourceTable targetTable sourceColumn targetColumn sourceAlias targetAlias join |
	
	usedTables at: aCollection ifPresent: [ ^ self ].
	
	usedSourceTable := usedTables at: aCollection allButLast.
	sourceTable := usedSourceTable table.
	targetTable := structure referencedTableFor: aCollection last in: sourceTable.
	
	sourceColumn := structure referencedColumnFor: targetTable in: sourceTable.
	targetColumn := structure primaryKeyIn: targetTable.
	
	sourceAlias := usedSourceTable alias.
	targetAlias := self aliasForTable: targetTable.
	
	usedTables at: aCollection put: (QRRUsedTable table: targetTable alias: targetAlias).
	
	join := QRRQueryJoin new.
	join table: targetTable.
	join alias: targetAlias.
	
	join condition: (self createJoinConditionFrom: sourceAlias column: sourceColumn to: targetAlias column: targetColumn).
	
	query addJoin: join