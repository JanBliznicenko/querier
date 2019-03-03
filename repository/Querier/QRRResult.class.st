Class {
	#name : #QRRResult,
	#superclass : #Object,
	#instVars : [
		'querier',
		'query',
		'rows',
		'rowEntities',
		'entityClass',
		'executed',
		'position',
		'primaryKeyColumn',
		'structure',
		'rowMapping',
		'columns',
		'usedTables'
	],
	#category : 'Querier-Result'
}

{ #category : #'instance creation' }
QRRResult class >> table: nameString querier: aQuerier structure: aStructure rowMapping: rowMapping [
	^ self new
		structure: aStructure;
		rowMapping: rowMapping;
		querier: aQuerier;
		table: nameString
]

{ #category : #'api - converting' }
QRRResult >> , aCollection [
	^ self asArray , aCollection
]

{ #category : #visiting }
QRRResult >> accept: aVisitor with: anObject [
	self flag: #todo. "only SELECT {primaryKey}"
	^ aVisitor visit: query with: anObject
]

{ #category : #'api - columns' }
QRRResult >> addColumnIdentifiedBy: aCollectionOfSymbols [
	query addColumn: (QRRQueryColumn identifiers: aCollectionOfSymbols)
]

{ #category : #'private - conditions' }
QRRResult >> addCondition: aCondition [

	
	self createJoinsIn: aCondition.
	
	query addCondition: aCondition
]

{ #category : #'private - conditions' }
QRRResult >> addConditionFrom: aCollectionOrBlock [
	aCollectionOrBlock isCollection
		ifTrue: [ self addConditionsFromDictionary: aCollectionOrBlock asDictionary ]
		ifFalse: [ self addCondition: (self createConditionFromBlock: aCollectionOrBlock) ]
]

{ #category : #'private - conditions' }
QRRResult >> addConditionsFromDictionary: aDictionary [
	aDictionary keysAndValuesDo: [ :key :value |
		| conditionClass |
		conditionClass :=
			(value isCollection and: [ value isString not ])
				ifTrue: [ QRRQueryInclusionOperation ]
				ifFalse: [ QRRQueryEqualComparison ].
		
		self addCondition:
			(conditionClass left: (self createTableColumn: key) right: value asQuerierExpression) ]
]

{ #category : #modifications }
QRRResult >> addNewRow: aDictionary [
	| row |
	
	row := self createNewRowFor: aDictionary.
	
	^ rows at: 1 put: row
]

{ #category : #'api - aggregations' }
QRRResult >> aggregation: aString [
	^ self executeAggregation: (QRRQueryLiteral with: aString)
]

{ #category : #'private - aggregations' }
QRRResult >> aggregation: aFunctionClass column: aSymbolOrBlock [
	| column |
	
	column := aFunctionClass expression: (aSymbolOrBlock value: self createTableColumn).
	
	^ self executeAggregation: column
]

{ #category : #private }
QRRResult >> aliasForTable: aString [
	| alias index |
	
	alias := aString.
	index := 1.
	
	[ usedTables includes: alias ]
		whileTrue: [
			alias := aString , '__' , (index := index + 1) asString ].
	
	^ alias
]

{ #category : #'api - limiting' }
QRRResult >> allButFirst: anInteger [
	self offset: anInteger
]

{ #category : #'api - converting' }
QRRResult >> asArray [
	^ self fetchAll
]

{ #category : #'api - converting' }
QRRResult >> asCollection [
	^ self asArray
]

{ #category : #converting }
QRRResult >> asQuerierExpression [
	^ QRRQueryNestedQuery with: self
]

{ #category : #converting }
QRRResult >> asString [
	^ self queryString
]

{ #category : #'api - enumerating' }
QRRResult >> associations [
	self execute.
	
	^ rows associations
]

{ #category : #'api - enumerating' }
QRRResult >> associationsDo: aBlock [
	self execute.
	
	rows associationsDo: aBlock
]

{ #category : #'api - enumerating' }
QRRResult >> associationsFrom: keyColumn to: valueColumn [
	self columns: { keyColumn asString. valueColumn asString }.
	self execute.
	
	^ Array new: self size streamContents: [ :stream |
			self do: [ :each |
				stream nextPut: (keyColumn value: each) -> (valueColumn value: each) ] ]
]

{ #category : #'api - enumerating' }
QRRResult >> associationsOf: aColumn [
	self execute.
	
	^ Array new: self size streamContents: [ :stream |
			self associationsDo: [ :each |
				stream nextPut: each key -> (aColumn value: each value) ] ]
]

{ #category : #api }
QRRResult >> at: primaryKey [
	executed ifFalse: [
		^ self fetchOneByPrimaryKey: primaryKey ].
	
	self execute.
	
	^ rows at: primaryKey
]

{ #category : #api }
QRRResult >> at: primaryKey ifAbsent: aBlock [
	executed ifFalse: [
		^ (self fetchOneByPrimaryKey: primaryKey) ifNil: aBlock ].
	
	self execute.
	
	^ rows at: primaryKey ifAbsent: aBlock
]

{ #category : #'api - index access' }
QRRResult >> atIndex: anInteger [
	| primaryKey |
	
	self execute.
	
	self flag: #todo. "throw an exception"
	primaryKey := rows keyAtIndex: anInteger ifAbsent: [ ^ nil ].
	
	^ rows at: primaryKey
]

{ #category : #'api - aggregations' }
QRRResult >> average: aSymbolOrBlock [
	^ self aggregation: QRRQueryAverageFunction column: aSymbolOrBlock
]

{ #category : #'api - enumerating' }
QRRResult >> collect: aSymbolOrBlock [
	^ self values: aSymbolOrBlock
]

{ #category : #'api - enumerating' }
QRRResult >> columnValues: aSymbol [
	self columns: { aSymbol asString }.
	
	^ self values: aSymbol
]

{ #category : #'api - columns' }
QRRResult >> columns: aCollection [
	aCollection do: [ :each |
		query addColumn: (self createColumn: each) ]
]

{ #category : #'lazy loading' }
QRRResult >> connectTableForKey: key forValues: aDictionary [
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
]

{ #category : #'private - references' }
QRRResult >> connectedColumnFor: key [
	^ structure connectedColumnFor: key in: self table
]

{ #category : #'private - references' }
QRRResult >> connectedTableFor: key [
	^ structure connectedTableFor: key in: self table
]

{ #category : #api }
QRRResult >> count [
	self flag: #todo. "star is SQL-specific, refactor it to a class"
	executed
		ifTrue: [ ^ self size ]
		ifFalse: [ ^ self executeAggregation: (QRRQueryCountFunction expression: (QRRQueryLiteral with: '*')) ]
]

{ #category : #'api - aggregations' }
QRRResult >> count: aSymbolOrBlock [
	^ self aggregation: QRRQueryCountFunction column: aSymbolOrBlock
]

{ #category : #'api - aggregations' }
QRRResult >> countDistinct: aSymbolOrBlock [
	^ self
			aggregation: QRRQueryCountFunction
			column: [ :column |
				QRRQueryDistinctOperation
					expression: (aSymbolOrBlock value: column) ]
]

{ #category : #'private - columns' }
QRRResult >> createColumn: aString [
	^ QRRQueryColumn identifier: aString
]

{ #category : #'private - conditions' }
QRRResult >> createConditionFromBlock: aBlock [
	^ aBlock value: (self createTableColumn)
]

{ #category : #'private - connected tables' }
QRRResult >> createConnectionsForColumn: aColumn [
	| identifierCount |
	
	identifierCount := aColumn qrrGetIdentifiers size.
	

]

{ #category : #'private - modifications' }
QRRResult >> createExistingRowFor: aDictionary [
	^ rowMapping createExistingRowFor: aDictionary result: self
]

{ #category : #'private - joins' }
QRRResult >> createJoinConditionFrom: sourceTable column: sourceColumn to: targetTable column: targetColumn [
	| conditionSource conditionTarget |
	conditionSource := QRRQueryColumn
		identifiers: (Array with: sourceTable with: sourceColumn).
	conditionTarget := QRRQueryColumn
		identifiers: (Array with: targetTable with: targetColumn).
	^ QRRQueryEqualComparison left: conditionSource right: conditionTarget
]

{ #category : #'private - joins' }
QRRResult >> createJoinForTables: aCollection [
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
]

{ #category : #accessing }
QRRResult >> createJoinFrom: sourceTable column: sourceColumn to: targetTable column: targetColumn [
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
]

{ #category : #'private - joins' }
QRRResult >> createJoinsForColumn: aQueryColumn [
	| identifiers finalJoinAlias |
	
	identifiers := aQueryColumn qrrGetIdentifiers.
	
	2 to: identifiers size - 1 do: [ :count |
		self createJoinForTables: (identifiers first: count) ].
	
	finalJoinAlias := (usedTables at: identifiers allButLast) alias.
	
	aQueryColumn qrrSetIdentifiers: (Array with: finalJoinAlias with: identifiers last)
]

{ #category : #'private - joins' }
QRRResult >> createJoinsIn: aQueryExpression [
	QRRQueryPluggableColumnVisitor columnsIn: aQueryExpression do: [ :each |
		each qrrGetIdentifiers size >= 2 ifTrue: [
			self createJoinsForColumn: each ].
		self createConnectionsForColumn: each ]
	
	"(QRRQueryJoinDetector detectJoinColumnsIn: aQueryExpression)
		do: [ :each |
			self createJoinsForColumn: each ]"
]

{ #category : #'private - columns' }
QRRResult >> createMutableColumn: aString [
	^ QRRQueryMutableColumn identifier: aString
]

{ #category : #'private - columns' }
QRRResult >> createMutableTableColumn [
	^ self createMutableColumn: self table
]

{ #category : #'private - modifications' }
QRRResult >> createNewRowFor: aDictionary [
	^ rowMapping createNewRowFor: aDictionary result: self
]

{ #category : #'private - ordering' }
QRRResult >> createOrderColumnFrom: aSymbolOrBlock [
	| column |
	
	column := aSymbolOrBlock value: self createTableColumn.
	self createJoinsForColumn: column.
	
	^ column
]

{ #category : #'private - conditions' }
QRRResult >> createPrimaryKeyInclusionCondition [
	^ QRRQueryInclusionOperation
			left: (self createTableColumn: primaryKeyColumn)
			right: self keys asQuerierExpression.
]

{ #category : #'private - columns' }
QRRResult >> createTableColumn [
	^ self createColumn: self table
]

{ #category : #'private - columns' }
QRRResult >> createTableColumn: aString [
	^ QRRQueryColumn identifiers: (Array with: self table with: aString)
]

{ #category : #'api - modifications' }
QRRResult >> delete [
	executed
		ifTrue: [ ^ self deleteAllRowsFromResult ]
		ifFalse: [ ^ self deleteWithCondition: query condition ]
]

{ #category : #'api - modifications' }
QRRResult >> delete: aCollectionOrBlock [
	^ (self select: aCollectionOrBlock) delete
]

{ #category : #'private - modifications' }
QRRResult >> deleteAllRowsFromResult [
	| condition |
	
	primaryKeyColumn ifNil: [
		self errorInvalidModification: 'Cannot delete selected rows because table ' , self table , ' is missing a primary key.'.
		^ 0 ].
	
	"No rows => nothing to do."
	self size = 0
		ifTrue: [ ^ 0 ].
	
	condition := self createPrimaryKeyInclusionCondition.
	
	^ self deleteWithCondition: condition
]

{ #category : #modifications }
QRRResult >> deleteRow: aRow [
	| condition |
	
	self flag: #todo. "raise exception"
	primaryKeyColumn ifNil: [ ^ 0 ].
	
	condition :=
		(QRRQueryEqualComparison
			left: (self createTableColumn: primaryKeyColumn)
			right: (aRow at: primaryKeyColumn) asQuerierExpression).
	
	^ self deleteWithCondition: condition
]

{ #category : #'private - modifications' }
QRRResult >> deleteWithCondition: aCondition [
	| deleteQuery queryResult |
	
	deleteQuery := QRRDeleteQuery new table: self table.
	deleteQuery addCondition: aCondition.
	
	queryResult := querier executeQuery: deleteQuery.
	self flag: #todo. "handle exceptions"
	
	^ queryResult affectedRows
]

{ #category : #'api - enumerating' }
QRRResult >> detect: aBlock [
	^ self detect: aBlock ifNone: []
]

{ #category : #'api - enumerating' }
QRRResult >> detect: aBlock ifFound: foundBlock [
	^ self detect: aBlock ifFound: foundBlock ifNone: []
]

{ #category : #'api - enumerating' }
QRRResult >> detect: aBlock ifFound: foundBlock ifNone: notFoundBlock [
	| row |
	
	self select: aBlock.
	self limit: 1.
	
	row := self fetchOne.
	
	^ row ifNotNil: foundBlock ifNil: notFoundBlock
]

{ #category : #'api - enumerating' }
QRRResult >> detect: aBlock ifNone: notFoundBlock [
	^ self detect: aBlock ifFound: [ :row | row ] ifNone: notFoundBlock
]

{ #category : #'api - enumerating' }
QRRResult >> do: aBlock [
	self execute.
	
	rows valuesDo: aBlock
]

{ #category : #accessing }
QRRResult >> entityClass [
	^ entityClass
]

{ #category : #accessing }
QRRResult >> entityClass: anObject [
	entityClass := anObject
]

{ #category : #private }
QRRResult >> errorInvalidModification: messageString [
	^ QRRInvalidModification new
		table: self table;
		signal: messageString
]

{ #category : #api }
QRRResult >> execute [
	| queryResult |
	
	executed ifTrue: [ ^ self ].
	executed := true.
	
	rows := OrderedDictionary new.
	entityClass
		ifNotNil: [ rowEntities := nil ]
		ifNil: [ rowEntities := rows ].
	self resetPosition.
	
	queryResult := querier executeQuery: query.
	self flag: #todo. "handle exceptions"
	
	queryResult rowsDo: [ :rowDict |
		| primaryKey |
		primaryKey := (self primaryKeyForRow: rowDict) ifNil: [ rows size + 1 ].
		
		rows at: primaryKey put: (self createExistingRowFor: rowDict) ].
	
	columns := queryResult columns.
	
	self queryExecuted
]

{ #category : #'private - aggregations' }
QRRResult >> executeAggregation: aColumn [
	| aggregationQuery result |
	
	aggregationQuery := QRRSelectQuery new table: self table.
	aggregationQuery addColumn: aColumn.
	aggregationQuery copyConditionFrom: query.
	aggregationQuery copyGroupingFrom: query.
	aggregationQuery copyJoinsFrom: query.
	
	result := querier executeQuery: aggregationQuery.
	self flag: #todo. "handle exceptions"
	
	"one row with one column only"
	result rowsDo: [ :row | ^ row anyOne ]
]

{ #category : #'api - enumerating' }
QRRResult >> fetchAll [
	self execute.
	
	^ rows values
]

{ #category : #'api - enumerating' }
QRRResult >> fetchOne [
	| primaryKey |
	
	self execute.
	
	primaryKey := rows keyAtIndex: position ifAbsent: [ ^ nil ].
	
	position := position + 1.
	
	^ rows at: primaryKey
]

{ #category : #'api - enumerating' }
QRRResult >> fetchOne: aCollectionOrBlock [
	^ self detect: aCollectionOrBlock
]

{ #category : #api }
QRRResult >> fetchOneByPrimaryKey: primaryKey [
	| result |
	
	result := querier table: self table.
	result limit: 1.
	
	primaryKeyColumn
		ifNotNil: [ result select: {primaryKeyColumn -> primaryKey} ]
		ifNil: [ result offset: primaryKey - 1 ].
	
	^ result fetchOne
]

{ #category : #'api - index access' }
QRRResult >> first [
	^ self atIndex: 1
]

{ #category : #'api - limiting' }
QRRResult >> first: anInteger [
	self limit: anInteger
]

{ #category : #'api - index access' }
QRRResult >> fourth [
	^ self atIndex: 4
]

{ #category : #'api - limiting' }
QRRResult >> from: fromInteger to: toInteger [
	self limit: toInteger - fromInteger + 1.
	self offset: fromInteger - 1
]

{ #category : #'api - grouping' }
QRRResult >> groupBy: aSymbolOrBlockOrCollection [
	| groupColumns |
	
	groupColumns := aSymbolOrBlockOrCollection isCollection
		ifTrue: [ aSymbolOrBlockOrCollection collect: [ :each | self createTableColumn: each ] ]
		ifFalse: [ Array with: (aSymbolOrBlockOrCollection value: self createTableColumn) ].
	
	groupColumns do: [ :each |
		query grouping addColumn: each ]
]

{ #category : #'api - grouping' }
QRRResult >> groupBy: aSymbolOrBlockOrCollection having: aBlock [
	self groupBy: aSymbolOrBlockOrCollection.
	self having: aBlock
]

{ #category : #'api - grouping' }
QRRResult >> having: aBlock [
	query grouping addCondition: (self createConditionFromBlock: aBlock)
]

{ #category : #initialization }
QRRResult >> initialize [
	super initialize.
	
	query := QRRSelectQuery new.
	usedTables := Dictionary new.
	executed := false.
	rows := OrderedDictionary new
]

{ #category : #modifications }
QRRResult >> insertRow: aRow [
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
]

{ #category : #'lazy loading' }
QRRResult >> keyNotFound: key forValues: aDictionary [
	| foreignKey primaryKey targetTable targetResult allValues |
	
	self flag: #todo.
	"TODO: load all columns if not all were loaded the first time + clear/update the column cache"
	
	foreignKey := self referencedColumnFor: key.
	aDictionary at: foreignKey ifAbsent: [ ^ self connectTableForKey: key forValues: aDictionary ].
	targetTable := self referencedTableFor: key.
	
	allValues := rows collect: foreignKey asSymbol thenReject: [ :each | each isNil ].
	primaryKey := structure primaryKeyIn: targetTable.
	
	targetResult := querier table: targetTable.
	targetResult select: {primaryKey -> allValues}.
	targetResult execute.
	
	rows do: [ :each |
		each
			referencedRowAt: key
			put: (targetResult at: (each at: foreignKey) ifAbsent: [ nil ]) ]
]

{ #category : #'api - enumerating' }
QRRResult >> keys [
	self execute.
	
	^ rows keys
]

{ #category : #'api - index access' }
QRRResult >> last [
	^ self atIndex: self size
]

{ #category : #'api - limiting' }
QRRResult >> limit: anInteger [
	query limit limit: anInteger
]

{ #category : #'api - limiting' }
QRRResult >> limit: limitInteger offset: offsetInteger [
	self limit: limitInteger.
	self offset: offsetInteger
]

{ #category : #'api - aggregations' }
QRRResult >> max: aSymbolOrBlock [
	^ self aggregation: QRRQueryMaxFunction column: aSymbolOrBlock
]

{ #category : #'api - aggregations' }
QRRResult >> min: aSymbolOrBlock [
	^ self aggregation: QRRQueryMinFunction column: aSymbolOrBlock
]

{ #category : #'api - modifications' }
QRRResult >> new [
	^ self new: Dictionary new
]

{ #category : #'api - modifications' }
QRRResult >> new: aDictionary [
	"Create a new result so that #delete or #update: on the current one do not affect the newly created row."
	^ (self class table: self table querier: querier structure: structure rowMapping: rowMapping)
			addNewRow: aDictionary asDictionary
]

{ #category : #'api - index access' }
QRRResult >> nextToLast [
	^ self atIndex: self size - 1
]

{ #category : #'api - enumerating' }
QRRResult >> nonEmptyValues: aSymbolOrBlock [
	self execute.
	
	^ Array new: self size streamContents: [ :stream |
			self do: [ :each |
				| value |
				value := aSymbolOrBlock value: each.
				value ifNotNil: [ stream nextPut: value ] ] ]
]

{ #category : #'api - limiting' }
QRRResult >> offset: anInteger [
	query limit offset: anInteger
]

{ #category : #'api - ordering' }
QRRResult >> orderAscendinglyBy: aSymbolOrBlock [
	query ordering addAscendingColumn: (self createOrderColumnFrom: aSymbolOrBlock)
]

{ #category : #'api - ordering' }
QRRResult >> orderBy: aSymbolOrBlock [
	self orderAscendinglyBy: aSymbolOrBlock
]

{ #category : #'api - ordering' }
QRRResult >> orderDescendinglyBy: aSymbolOrBlock [
	query ordering addDescendingColumn: (self createOrderColumnFrom: aSymbolOrBlock)
]

{ #category : #private }
QRRResult >> primaryKeyForRow: aDictionary [
	primaryKeyColumn ifNil: [ ^ nil ].
	
	^ aDictionary at: primaryKeyColumn ifAbsent: [ nil ]
]

{ #category : #'private - accessing' }
QRRResult >> querier: aQuerier [
	querier := aQuerier
]

{ #category : #'private - events' }
QRRResult >> queryExecuted [
	rowMapping queryExecuted: self
]

{ #category : #api }
QRRResult >> queryString [
	^ querier buildQueryStringFrom: query
]

{ #category : #'private - references' }
QRRResult >> referencedColumnFor: key [
	^ structure referencedColumnFor: key in: self table
]

{ #category : #'private - references' }
QRRResult >> referencedTableFor: key [
	^ structure referencedTableFor: key in: self table
]

{ #category : #'api - modifications' }
QRRResult >> removeAll [
	^ self delete
]

{ #category : #'api - enumerating' }
QRRResult >> resetPosition [
	position := 1
]

{ #category : #'private - accessing' }
QRRResult >> rowMapping: aRowMapping [
	rowMapping := aRowMapping
]

{ #category : #modifications }
QRRResult >> saveRow: aRow withColumns: aCollection [
	| updateQuery condition queryResult |
	
	self flag: #todo. "raise exception"
	primaryKeyColumn ifNil: [ ^ 0 ].
	
	updateQuery := QRRUpdateQuery new table: self table.
	
	condition :=
		(QRRQueryEqualComparison
			left: (self createTableColumn: primaryKeyColumn)
			right: (aRow at: primaryKeyColumn) asQuerierExpression).
	
	updateQuery addCondition: condition.
	
	aCollection do: [ :each |
		updateQuery addColumn: (self createTableColumn: each) value: (aRow at: each) ].
	
	queryResult := querier executeQuery: updateQuery.
	
	^ queryResult affectedRows
]

{ #category : #'api - index access' }
QRRResult >> second [
	^ self atIndex: 2
]

{ #category : #'api - conditions' }
QRRResult >> select: aCollectionOrBlock [
	self addConditionFrom: aCollectionOrBlock
]

{ #category : #api }
QRRResult >> size [
	self execute.
	
	^ rows size
]

{ #category : #'api - ordering' }
QRRResult >> sorted: aBlock [
	"Example:
		aResult sorted: [ :a :b | a date < b date ]
	Currently, this is limited to one expression in the form of the previous example, no combinations (#& or #and:)."
	| comparison column |
	
	comparison := aBlock value: self createTableColumn value: self createTableColumn.
	column := comparison leftExpression.
	self createJoinsForColumn: column.
	
	(#(#> #>=) includes: comparison operatorSymbol)
		ifTrue: [ query ordering addDescendingColumn: column ]
		ifFalse: [ query ordering addAscendingColumn: column ]
]

{ #category : #'private - accessing' }
QRRResult >> structure: aStructure [
	structure := aStructure
]

{ #category : #'api - aggregations' }
QRRResult >> sum: aSymbolOrBlock [
	^ self aggregation: QRRQuerySumFunction column: aSymbolOrBlock
]

{ #category : #accessing }
QRRResult >> table [
	^ query table
]

{ #category : #'private - accessing' }
QRRResult >> table: aString [
	query table: aString.
	primaryKeyColumn := structure primaryKeyIn: aString.
	
	usedTables at: (Array with: aString) put: (QRRUsedTable table: aString)
]

{ #category : #'api - index access' }
QRRResult >> third [
	^ self atIndex: 3
]

{ #category : #'api - modifications' }
QRRResult >> update: aBlock [
	| updateQuery condition queryResult |
	
	(executed and: [ primaryKeyColumn isNil ])
		ifTrue: [
			self errorInvalidModification: 'Cannot update selected rows because table ' , self table , ' is missing a primary key.'.
			^ 0 ].
	
	"No rows => nothing to do."
	(executed and: [ self size = 0 ])
		ifTrue: [ ^ 0 ].
	
	condition :=
		executed
			ifTrue: [ self createPrimaryKeyInclusionCondition ]
			ifFalse: [ query condition ].
	
	updateQuery := QRRUpdateQuery new table: self table.
	updateQuery addCondition: condition.
	
	[ aBlock value: self createMutableTableColumn ]
		on: QRRModificationNotification do: [ :modification |
			updateQuery
				addColumn: modification column
				value: modification value.
			modification resume ].
	
	queryResult := querier executeQuery: updateQuery.
	self flag: #todo. "check for exceptions"
	
	^ queryResult affectedRows
]

{ #category : #'api - enumerating' }
QRRResult >> values: aSymbolOrBlock [
	self execute.
	
	^ Array new: self size streamContents: [ :stream |
			self do: [ :each |
				stream nextPut: (aSymbolOrBlock value: each) ] ]
]
