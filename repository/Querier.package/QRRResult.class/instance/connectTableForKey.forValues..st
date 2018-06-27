lazy loading
connectTableForKey: key forValues: aDictionary
	| connectingKey primaryKey targetTable targetQuery targetResult allValues |
	
	targetTable := self connectedTableFor: key.
	targetTable ifNil: [ ^ self ].
	connectingKey := self connectedColumnFor: key.
	aDictionary at: connectingKey ifAbsent: [ ^ nil ].
	
	allValues := rows collect: connectingKey asSymbol thenReject: [ :each | each isNil ].
	primaryKey := structure primaryKeyIn: targetTable.
	
	targetQuery := QRRSelectQuery new table: targetTable.
	targetQuery addCondition:
		(QRRQueryInclusionOperation
			left: (QRRQueryColumn identifiers: (Array with: targetTable with: primaryKey))
			right: allValues asQuerierExpression).
	targetResult := querier executeQuery: targetQuery.
	
	targetResult rowsDo: [ :targetRow |
		| sourceRow |
		sourceRow := (rows at: (targetRow at: primaryKey)).
		targetRow keysAndValuesDo: [ :field :value |
			sourceRow fieldAt: field ifAbsentPut: [ value ] ] ].