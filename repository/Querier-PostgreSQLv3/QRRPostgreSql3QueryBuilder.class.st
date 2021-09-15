Class {
	#name : #QRRPostgreSql3QueryBuilder,
	#superclass : #QRRQueryBuilder,
	#category : #'Querier-PostgreSQLv3'
}

{ #category : #helpers }
QRRPostgreSql3QueryBuilder >> binaryOperationSymbol: aSymbol [
	^ {
			#~= -> #!=.
			#':=' -> #=
		} asDictionary
			at: aSymbol
			ifAbsent: [ aSymbol ]
]

{ #category : #api }
QRRPostgreSql3QueryBuilder >> buildStringFrom: aQuery [
	^ String streamContents: [ :stream |
			| streamWrapper |
			
			streamWrapper := QRRPostgreSql3QueryBuilderStream new stream: stream.
			
			self visit: aQuery with: streamWrapper ]
]

{ #category : #helpers }
QRRPostgreSql3QueryBuilder >> enclose: aString in: enclosingChar [
	^ String streamContents: [ :stream |
			stream nextPut: enclosingChar.
			aString do: [ :char |
				stream nextPut: char.
				char = enclosingChar ifTrue: [
					stream nextPut: enclosingChar ] ].
			stream nextPut: enclosingChar ]
]

{ #category : #helpers }
QRRPostgreSql3QueryBuilder >> escapeIdentifier: aString [
	^ self enclose: aString in: self identifierEnclosingCharacter.
]

{ #category : #helpers }
QRRPostgreSql3QueryBuilder >> escapeValue: aString [
	^ self enclose: aString in: self valueEnclosingCharacter.
]

{ #category : #helpers }
QRRPostgreSql3QueryBuilder >> functionName: aSymbol [
	^ {
			#average -> #avg
		} asDictionary
			at: aSymbol
			ifAbsent: [ aSymbol ]
]

{ #category : #helpers }
QRRPostgreSql3QueryBuilder >> identifierEnclosingCharacter [
	^ $"
]

{ #category : #helpers }
QRRPostgreSql3QueryBuilder >> keywordForOrderDirection: aSymbol [
	^ aSymbol = #descending
			ifTrue: 'DESC'
			ifFalse: 'ASC'
]

{ #category : #helpers }
QRRPostgreSql3QueryBuilder >> numberConstantFor: anObject [
	^ anObject printString
]

{ #category : #private }
QRRPostgreSql3QueryBuilder >> parenthesized: aBlock on: aStream [
	aStream nextPut: $(.
	aBlock value.
	aStream nextPut: $)
]

{ #category : #private }
QRRPostgreSql3QueryBuilder >> printIfNotNil: anObject precededBy: aString on: aStream [
	anObject ifNil: [ ^ self ].
	
	aStream
		nextPutAll: aString;
		nextPutAll: anObject printString
]

{ #category : #helpers }
QRRPostgreSql3QueryBuilder >> stringConstantFor: aString [
	^ self escapeValue: aString
]

{ #category : #helpers }
QRRPostgreSql3QueryBuilder >> valueEnclosingCharacter [
	^ $'
]

{ #category : #'visiting - conditions' }
QRRPostgreSql3QueryBuilder >> visitCondition: aCondition precededBy: aString with: aStream [
	aCondition isEmpty ifTrue: [ ^ self ].
	
	aStream nextPutAll: aString.
	self visit: aCondition with: aStream
]

{ #category : #'visiting - queries' }
QRRPostgreSql3QueryBuilder >> visitDeleteQuery: aQuery with: aStream [
	aStream singleTableQuery: true.
	
	aStream
		nextPutAll: 'DELETE FROM ';
		nextPutAll: (self escapeIdentifier: aQuery table).
	
	self visitWhereCondition: aQuery condition with: aStream
]

{ #category : #'visiting - queries' }
QRRPostgreSql3QueryBuilder >> visitInsertQuery: aQuery with: aStream [
	aStream singleTableQuery: true.
	
	aStream
		nextPutAll: 'INSERT INTO ';
		nextPutAll: (self escapeIdentifier: aQuery table);
		nextPutAll: ' ('.
	
	aQuery
		columnsDo: [ :column |
			self visit: column with: aStream ]
		separatedBy: [
			aStream nextPutAll: ', ' ].
	
	aStream
		nextPutAll: ')';
		cr;
		nextPutAll: 'VALUES ('.
	
	aQuery
		valuesDo: [ :value |
			self visit: value with: aStream ]
		separatedBy: [
			aStream nextPutAll: ', ' ].
	
	aStream nextPutAll: ')'.
	
	aQuery returnRow ifTrue: [
		aStream
			cr;
			nextPutAll: 'RETURNING *' ]
]

{ #category : #'visiting - conditions' }
QRRPostgreSql3QueryBuilder >> visitQueryAndCondition: aQueryCondition with: aStream [
	self visitQueryCondition: aQueryCondition
		separatedBy: ' AND '
		with: aStream
]

{ #category : #'visiting - operations' }
QRRPostgreSql3QueryBuilder >> visitQueryAssignmentOperation: aQueryOperation with: aStream [
	self visitQueryBinaryOperationWithoutParentheses: aQueryOperation with: aStream
]

{ #category : #'visiting - operations' }
QRRPostgreSql3QueryBuilder >> visitQueryBinaryOperation: aQueryOperation with: aStream [
	self
		parenthesized: [
			self visitQueryBinaryOperationWithoutParentheses: aQueryOperation with: aStream ]
		on: aStream
]

{ #category : #'visiting - operations' }
QRRPostgreSql3QueryBuilder >> visitQueryBinaryOperationWithoutParentheses: aQueryOperation with: aStream [
	self visit: aQueryOperation leftExpression with: aStream.
	aStream
		space;
		nextPutAll: (self binaryOperationSymbol: aQueryOperation operatorSymbol);
		space.
	self visit: aQueryOperation rightExpression with: aStream
]

{ #category : #'visiting - expressions' }
QRRPostgreSql3QueryBuilder >> visitQueryCollectionConstant: aQueryConstant with: aStream [
	aStream nextPut: $(.
	
	aQueryConstant value
		do: [ :each |
			self visit: each with: aStream ]
		separatedBy: [
			aStream nextPutAll: ', ' ].
	
	aStream nextPut: $)
]

{ #category : #'visiting - expressions' }
QRRPostgreSql3QueryBuilder >> visitQueryColumn: aQueryColumn with: aStream [
	| hideFirst |
	
	hideFirst := aStream singleTableQuery.
	
	aQueryColumn
		identifiersDo: [ :identifier |
			hideFirst ifFalse: [
				aStream nextPutAll: (self escapeIdentifier: identifier) ] ]
		separatedBy: [
			hideFirst
				ifTrue: [ hideFirst := false ]
				ifFalse: [ aStream nextPut: $. ] ]
]

{ #category : #'visiting - conditions' }
QRRPostgreSql3QueryBuilder >> visitQueryCondition: aQueryCondition separatedBy: separatorString with: aStream [
	"If there are no conditions, pass a placeholder (always-true expression)."
	aQueryCondition isEmpty
		ifTrue: [
			aStream nextPutAll: 'true'.
			^ self ].
	
	self
		parenthesized: [
			aQueryCondition
				conditionsDo: [ :condition |
					self visit: condition with: aStream ]
				separatedBy: [
					aStream nextPutAll: separatorString ] ]
		on: aStream
]

{ #category : #'visiting - operations' }
QRRPostgreSql3QueryBuilder >> visitQueryDistinctOperation: aQueryOperation with: aStream [
	aStream nextPutAll: 'DISTINCT '.
	
	self visit: aQueryOperation expression with: aStream
]

{ #category : #'visiting - operations' }
QRRPostgreSql3QueryBuilder >> visitQueryExistenceOperation: aQueryOperation with: aStream [
	self
		parenthesized: [
			aStream nextPutAll: ' EXISTS '.
			
			self visit: aQueryOperation rightExpression with: aStream ]
		on: aStream
]

{ #category : #'visiting - functions' }
QRRPostgreSql3QueryBuilder >> visitQueryFunction: aQueryFunction with: aStream [
	aStream nextPutAll: (self functionName: aQueryFunction functionName) asUppercase.
	
	aStream nextPut: $(.
	
	aQueryFunction
		expressionsDo: [ :each |
			self visit: each with: aStream ]
		separatedBy: [
			aStream nextPutAll: ', ' ].
	
	aStream nextPut: $)
]

{ #category : #'visiting - query parts' }
QRRPostgreSql3QueryBuilder >> visitQueryGrouping: aQueryGrouping with: aStream [
	aQueryGrouping isEmpty ifTrue: [
		^ self ].
	
	aStream nextPutAll: ' GROUP BY '.
	
	aQueryGrouping
		columnsDo: [ :column |
			self visit: column with: aStream ]
		separatedBy: [
			aStream nextPutAll: ', ' ].
	
	self visitCondition: aQueryGrouping condition
		precededBy: ' HAVING '
		with: aStream
]

{ #category : #'visiting - expressions' }
QRRPostgreSql3QueryBuilder >> visitQueryIdentifier: aQueryIdentifier with: aStream [
	aStream nextPutAll: (self escapeIdentifier: aQueryIdentifier value)
]

{ #category : #'visiting - operations' }
QRRPostgreSql3QueryBuilder >> visitQueryInclusionOperation: aQueryOperation with: aStream [
	self
		parenthesized: [
			self visit: aQueryOperation leftExpression with: aStream.
			
			aStream nextPutAll: ' IN '.
			
			self visit: aQueryOperation rightExpression with: aStream ]
		on: aStream
]

{ #category : #'visiting - operations' }
QRRPostgreSql3QueryBuilder >> visitQueryIsNotNullOperation: aQueryOperation with: aStream [
	self visit: aQueryOperation expression with: aStream.
	aStream nextPutAll: ' IS NOT NULL '
]

{ #category : #'visiting - operations' }
QRRPostgreSql3QueryBuilder >> visitQueryIsNullOperation: aQueryOperation with: aStream [
	self visit: aQueryOperation expression with: aStream.
	aStream nextPutAll: ' IS NULL '
]

{ #category : #'visiting - query parts' }
QRRPostgreSql3QueryBuilder >> visitQueryJoin: aQueryJoin with: aStream [
	aStream
		cr;
		nextPutAll: 'LEFT JOIN ';
		nextPutAll: (self escapeIdentifier: aQueryJoin table).
	
	(aQueryJoin alias ~= aQueryJoin table)
		ifTrue: [
			aStream
				nextPutAll: ' AS ';
				nextPutAll: (self escapeIdentifier: aQueryJoin alias) ].
	
	aStream nextPutAll: ' ON '.
	self visit: aQueryJoin condition with: aStream
]

{ #category : #'visiting - query parts' }
QRRPostgreSql3QueryBuilder >> visitQueryJoinsOf: aQuery with: aStream [
	aQuery joinsDo: [ :join |
		self visit: join with: aStream ]
]

{ #category : #'visiting - query parts' }
QRRPostgreSql3QueryBuilder >> visitQueryLimit: aQueryLimit with: aStream [
	self printIfNotNil: aQueryLimit limit
		precededBy: String cr , 'LIMIT '
		on: aStream.
	
	self printIfNotNil: aQueryLimit offset
		precededBy: String cr , ' OFFSET '
		on: aStream
]

{ #category : #'visiting - expressions' }
QRRPostgreSql3QueryBuilder >> visitQueryLiteral: aQueryLiteral with: aStream [
	aStream nextPutAll: aQueryLiteral value asString
]

{ #category : #'visiting - queries' }
QRRPostgreSql3QueryBuilder >> visitQueryNestedQuery: aNestedQuery with: aStream [
	self
		parenthesized: [
			self visit: aNestedQuery value with: aStream ]
		on: aStream
]

{ #category : #'visiting - operations' }
QRRPostgreSql3QueryBuilder >> visitQueryNonExistenceOperation: aQueryOperation with: aStream [
	self
		parenthesized: [
			aStream nextPutAll: ' NOT EXISTS '.
			
			self visit: aQueryOperation rightExpression with: aStream ]
		on: aStream
]

{ #category : #'visiting - operations' }
QRRPostgreSql3QueryBuilder >> visitQueryNonInclusionOperation: aQueryOperation with: aStream [
	self
		parenthesized: [
			self visit: aQueryOperation leftExpression with: aStream.
			
			aStream nextPutAll: ' NOT IN '.
			
			self visit: aQueryOperation rightExpression with: aStream ]
		on: aStream
]

{ #category : #'visiting - operations' }
QRRPostgreSql3QueryBuilder >> visitQueryNotOperation: aQueryOperation with: aStream [
	aStream nextPutAll: 'NOT '.
	self visit: aQueryOperation expression with: aStream
]

{ #category : #'visiting - expressions' }
QRRPostgreSql3QueryBuilder >> visitQueryNumberConstant: aQueryConstant with: aStream [
	aStream nextPutAll: (self numberConstantFor: aQueryConstant value)
]

{ #category : #'visiting - conditions' }
QRRPostgreSql3QueryBuilder >> visitQueryOrCondition: aQueryCondition with: aStream [
	self visitQueryCondition: aQueryCondition
		separatedBy: ' OR '
		with: aStream
]

{ #category : #'visiting - query parts' }
QRRPostgreSql3QueryBuilder >> visitQueryOrdering: aQueryOrdering with: aStream [
	aQueryOrdering isEmpty ifTrue: [
		^ self ].
	
	aStream
		cr;
		nextPutAll: 'ORDER BY '.
	
	aQueryOrdering
		columnsAndDirectionsDo: [ :column :direction |
			self visit: column with: aStream.
			aStream
				space;
				nextPutAll: (self keywordForOrderDirection: direction) ]
		separatedBy: [
			aStream nextPutAll: ', ' ]
]

{ #category : #'visiting - expressions' }
QRRPostgreSql3QueryBuilder >> visitQuerySimpleColumn: aQueryConstant with: aStream [
	(aQueryConstant identifiers collect: [ :each | self escapeIdentifier: each ])
		printOn: aStream
		delimiter: '.'
]

{ #category : #'visiting - expressions' }
QRRPostgreSql3QueryBuilder >> visitQueryStringConstant: aQueryConstant with: aStream [
	aStream nextPutAll: (self stringConstantFor: aQueryConstant value)
]

{ #category : #'visiting - queries' }
QRRPostgreSql3QueryBuilder >> visitSelectQuery: aQuery with: aStream [
	| hasColumns |
	aStream nextPutAll: 'SELECT '.
	hasColumns := false.
	aQuery
		columnsDo: [ :column | 
			self visit: column with: aStream.
			hasColumns := true ]
		separatedBy: [ aStream nextPutAll: ', ' ].
	hasColumns
		ifFalse: [ aStream
				nextPutAll: (self escapeIdentifier: aQuery table);
				nextPutAll: '.*' ].
	aStream
		cr;
		nextPutAll: 'FROM ';
		nextPutAll: (self escapeIdentifier: aQuery table).
	self visitQueryJoinsOf: aQuery with: aStream.
	self visitWhereCondition: aQuery condition with: aStream.
	self visit: aQuery grouping with: aStream.
	self visit: aQuery ordering with: aStream.
	self visit: aQuery limit with: aStream
]

{ #category : #'visiting - queries' }
QRRPostgreSql3QueryBuilder >> visitUpdateQuery: aQuery with: aStream [
	aStream singleTableQuery: true.
	
	aStream
		nextPutAll: 'UPDATE ';
		nextPutAll: (self escapeIdentifier: aQuery table);
		cr;
		nextPutAll: 'SET '.
	
	aQuery
		columnsAndValuesDo: [ :column :value |
			self visit: column with: aStream.
			aStream	 nextPutAll: ' = '.
			self visit: value with: aStream ]
		separatedBy: [
			aStream nextPutAll: ', ' ].
	
	self visitWhereCondition: aQuery condition with: aStream
]

{ #category : #'visiting - conditions' }
QRRPostgreSql3QueryBuilder >> visitWhereCondition: aCondition with: aStream [
	self visitCondition: aCondition precededBy: String cr , 'WHERE ' with: aStream
]
