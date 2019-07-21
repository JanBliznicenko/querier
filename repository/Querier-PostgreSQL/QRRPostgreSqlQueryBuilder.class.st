Class {
	#name : #QRRPostgreSqlQueryBuilder,
	#superclass : #QRRQueryBuilder,
	#category : 'Querier-PostgreSQL'
}

{ #category : #helpers }
QRRPostgreSqlQueryBuilder >> binaryOperationSymbol: aSymbol [
	^ {
			#~= -> #!=.
			#':=' -> #=
		} asDictionary
			at: aSymbol
			ifAbsent: [ aSymbol ]
]

{ #category : #api }
QRRPostgreSqlQueryBuilder >> buildStringFrom: aQuery [
	^ String streamContents: [ :stream |
			| streamWrapper |
			
			streamWrapper := QRRPostgreSqlQueryBuilderStream new stream: stream.
			
			self visit: aQuery with: streamWrapper ]
]

{ #category : #helpers }
QRRPostgreSqlQueryBuilder >> enclose: aString in: enclosingChar [
	^ String streamContents: [ :stream |
			stream nextPut: enclosingChar.
			aString do: [ :char |
				stream nextPut: char.
				char = enclosingChar ifTrue: [
					stream nextPut: enclosingChar ] ].
			stream nextPut: enclosingChar ]
]

{ #category : #helpers }
QRRPostgreSqlQueryBuilder >> escapeIdentifier: aString [
	^ self enclose: aString in: self identifierEnclosingCharacter.
]

{ #category : #helpers }
QRRPostgreSqlQueryBuilder >> escapeValue: aString [
	^ self enclose: aString in: self valueEnclosingCharacter.
]

{ #category : #helpers }
QRRPostgreSqlQueryBuilder >> functionName: aSymbol [
	^ {
			#average -> #avg
		} asDictionary
			at: aSymbol
			ifAbsent: [ aSymbol ]
]

{ #category : #helpers }
QRRPostgreSqlQueryBuilder >> identifierEnclosingCharacter [
	^ $"
]

{ #category : #helpers }
QRRPostgreSqlQueryBuilder >> keywordForOrderDirection: aSymbol [
	^ aSymbol = #descending
			ifTrue: 'DESC'
			ifFalse: 'ASC'
]

{ #category : #helpers }
QRRPostgreSqlQueryBuilder >> numberConstantFor: anObject [
	^ anObject printString
]

{ #category : #private }
QRRPostgreSqlQueryBuilder >> parenthesized: aBlock on: aStream [
	aStream nextPut: $(.
	aBlock value.
	aStream nextPut: $)
]

{ #category : #private }
QRRPostgreSqlQueryBuilder >> printIfNotNil: anObject precededBy: aString on: aStream [
	anObject ifNil: [ ^ self ].
	
	aStream
		nextPutAll: aString;
		nextPutAll: anObject printString
]

{ #category : #helpers }
QRRPostgreSqlQueryBuilder >> stringConstantFor: aString [
	^ self escapeValue: aString
]

{ #category : #helpers }
QRRPostgreSqlQueryBuilder >> valueEnclosingCharacter [
	^ $'
]

{ #category : #'visiting - conditions' }
QRRPostgreSqlQueryBuilder >> visitCondition: aCondition precededBy: aString with: aStream [
	aCondition isEmpty ifTrue: [ ^ self ].
	
	aStream nextPutAll: aString.
	self visit: aCondition with: aStream
]

{ #category : #'visiting - queries' }
QRRPostgreSqlQueryBuilder >> visitDeleteQuery: aQuery with: aStream [
	aStream singleTableQuery: true.
	
	aStream
		nextPutAll: 'DELETE FROM ';
		nextPutAll: (self escapeIdentifier: aQuery table).
	
	self visitWhereCondition: aQuery condition with: aStream
]

{ #category : #'visiting - queries' }
QRRPostgreSqlQueryBuilder >> visitInsertQuery: aQuery with: aStream [
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
QRRPostgreSqlQueryBuilder >> visitQueryAndCondition: aQueryCondition with: aStream [
	self visitQueryCondition: aQueryCondition
		separatedBy: ' AND '
		with: aStream
]

{ #category : #'visiting - operations' }
QRRPostgreSqlQueryBuilder >> visitQueryAssignmentOperation: aQueryOperation with: aStream [
	self visitQueryBinaryOperationWithoutParentheses: aQueryOperation with: aStream
]

{ #category : #'visiting - operations' }
QRRPostgreSqlQueryBuilder >> visitQueryBinaryOperation: aQueryOperation with: aStream [
	self
		parenthesized: [
			self visitQueryBinaryOperationWithoutParentheses: aQueryOperation with: aStream ]
		on: aStream
]

{ #category : #'visiting - operations' }
QRRPostgreSqlQueryBuilder >> visitQueryBinaryOperationWithoutParentheses: aQueryOperation with: aStream [
	self visit: aQueryOperation leftExpression with: aStream.
	aStream
		space;
		nextPutAll: (self binaryOperationSymbol: aQueryOperation operatorSymbol);
		space.
	self visit: aQueryOperation rightExpression with: aStream
]

{ #category : #'visiting - expressions' }
QRRPostgreSqlQueryBuilder >> visitQueryCollectionConstant: aQueryConstant with: aStream [
	aStream nextPut: $(.
	
	aQueryConstant value
		do: [ :each |
			self visit: each with: aStream ]
		separatedBy: [
			aStream nextPutAll: ', ' ].
	
	aStream nextPut: $)
]

{ #category : #'visiting - expressions' }
QRRPostgreSqlQueryBuilder >> visitQueryColumn: aQueryColumn with: aStream [
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
QRRPostgreSqlQueryBuilder >> visitQueryCondition: aQueryCondition separatedBy: separatorString with: aStream [
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
QRRPostgreSqlQueryBuilder >> visitQueryDistinctOperation: aQueryOperation with: aStream [
	aStream nextPutAll: 'DISTINCT '.
	
	self visit: aQueryOperation expression with: aStream
]

{ #category : #'visiting - operations' }
QRRPostgreSqlQueryBuilder >> visitQueryExistenceOperation: aQueryOperation with: aStream [
	self
		parenthesized: [
			aStream nextPutAll: ' EXISTS '.
			
			self visit: aQueryOperation rightExpression with: aStream ]
		on: aStream
]

{ #category : #'visiting - functions' }
QRRPostgreSqlQueryBuilder >> visitQueryFunction: aQueryFunction with: aStream [
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
QRRPostgreSqlQueryBuilder >> visitQueryGrouping: aQueryGrouping with: aStream [
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
QRRPostgreSqlQueryBuilder >> visitQueryIdentifier: aQueryIdentifier with: aStream [
	aStream nextPutAll: (self escapeIdentifier: aQueryIdentifier value)
]

{ #category : #'visiting - operations' }
QRRPostgreSqlQueryBuilder >> visitQueryInclusionOperation: aQueryOperation with: aStream [
	self
		parenthesized: [
			self visit: aQueryOperation leftExpression with: aStream.
			
			aStream nextPutAll: ' IN '.
			
			self visit: aQueryOperation rightExpression with: aStream ]
		on: aStream
]

{ #category : #'visiting - operations' }
QRRPostgreSqlQueryBuilder >> visitQueryIsNotNullOperation: aQueryOperation with: aStream [
	self visit: aQueryOperation expression with: aStream.
	aStream nextPutAll: ' IS NOT NULL '
]

{ #category : #'visiting - operations' }
QRRPostgreSqlQueryBuilder >> visitQueryIsNullOperation: aQueryOperation with: aStream [
	self visit: aQueryOperation expression with: aStream.
	aStream nextPutAll: ' IS NULL '
]

{ #category : #'visiting - query parts' }
QRRPostgreSqlQueryBuilder >> visitQueryJoin: aQueryJoin with: aStream [
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
QRRPostgreSqlQueryBuilder >> visitQueryJoinsOf: aQuery with: aStream [
	aQuery joinsDo: [ :join |
		self visit: join with: aStream ]
]

{ #category : #'visiting - query parts' }
QRRPostgreSqlQueryBuilder >> visitQueryLimit: aQueryLimit with: aStream [
	self printIfNotNil: aQueryLimit limit
		precededBy: String cr , 'LIMIT '
		on: aStream.
	
	self printIfNotNil: aQueryLimit offset
		precededBy: String cr , ' OFFSET '
		on: aStream
]

{ #category : #'visiting - expressions' }
QRRPostgreSqlQueryBuilder >> visitQueryLiteral: aQueryLiteral with: aStream [
	aStream nextPutAll: aQueryLiteral value asString
]

{ #category : #'visiting - queries' }
QRRPostgreSqlQueryBuilder >> visitQueryNestedQuery: aNestedQuery with: aStream [
	self
		parenthesized: [
			self visit: aNestedQuery value with: aStream ]
		on: aStream
]

{ #category : #'visiting - operations' }
QRRPostgreSqlQueryBuilder >> visitQueryNonExistenceOperation: aQueryOperation with: aStream [
	self
		parenthesized: [
			aStream nextPutAll: ' NOT EXISTS '.
			
			self visit: aQueryOperation rightExpression with: aStream ]
		on: aStream
]

{ #category : #'visiting - operations' }
QRRPostgreSqlQueryBuilder >> visitQueryNonInclusionOperation: aQueryOperation with: aStream [
	self
		parenthesized: [
			self visit: aQueryOperation leftExpression with: aStream.
			
			aStream nextPutAll: ' NOT IN '.
			
			self visit: aQueryOperation rightExpression with: aStream ]
		on: aStream
]

{ #category : #'visiting - operations' }
QRRPostgreSqlQueryBuilder >> visitQueryNotOperation: aQueryOperation with: aStream [
	aStream nextPutAll: 'NOT '.
	self visit: aQueryOperation expression with: aStream
]

{ #category : #'visiting - expressions' }
QRRPostgreSqlQueryBuilder >> visitQueryNumberConstant: aQueryConstant with: aStream [
	aStream nextPutAll: (self numberConstantFor: aQueryConstant value)
]

{ #category : #'visiting - conditions' }
QRRPostgreSqlQueryBuilder >> visitQueryOrCondition: aQueryCondition with: aStream [
	self visitQueryCondition: aQueryCondition
		separatedBy: ' OR '
		with: aStream
]

{ #category : #'visiting - query parts' }
QRRPostgreSqlQueryBuilder >> visitQueryOrdering: aQueryOrdering with: aStream [
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
QRRPostgreSqlQueryBuilder >> visitQuerySimpleColumn: aQueryConstant with: aStream [
	(aQueryConstant identifiers collect: [ :each | self escapeIdentifier: each ])
		printOn: aStream
		delimiter: '.'
]

{ #category : #'visiting - expressions' }
QRRPostgreSqlQueryBuilder >> visitQueryStringConstant: aQueryConstant with: aStream [
	aStream nextPutAll: (self stringConstantFor: aQueryConstant value)
]

{ #category : #'visiting - queries' }
QRRPostgreSqlQueryBuilder >> visitSelectQuery: aQuery with: aStream [
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
QRRPostgreSqlQueryBuilder >> visitUpdateQuery: aQuery with: aStream [
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
QRRPostgreSqlQueryBuilder >> visitWhereCondition: aCondition with: aStream [
	self visitCondition: aCondition precededBy: String cr , 'WHERE ' with: aStream
]
