accessing
createJoinFrom: sourceTable column: sourceColumn to: targetTable column: targetColumn
	| join |
	join := QRRQueryJoin new
		table: targetTable;
		alias: targetTable;
		condition:
			(self
				createJoinConditionFrom: sourceTable
				column: sourceColumn
				to: targetTable
				column: targetColumn);
		yourself.
	query addJoin: join