private - joins
createJoinConditionFrom: sourceTable column: sourceColumn to: targetTable column: targetColumn
	| conditionSource conditionTarget |
	conditionSource := QRRQueryColumn
		identifiers: (Array with: sourceTable with: sourceColumn).
	conditionTarget := QRRQueryColumn
		identifiers: (Array with: targetTable with: targetColumn).
	^ QRRQueryEqualComparison left: conditionSource right: conditionTarget