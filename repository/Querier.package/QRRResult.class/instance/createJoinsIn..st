private - joins
createJoinsIn: aQueryExpression
	QRRQueryPluggableColumnVisitor columnsIn: aQueryExpression do: [ :each |
		each qrrGetIdentifiers size >= 2 ifTrue: [
			self createJoinsForColumn: each ].
		self createConnectionsForColumn: each ]
	
	"(QRRQueryJoinDetector detectJoinColumnsIn: aQueryExpression)
		do: [ :each |
			self createJoinsForColumn: each ]"