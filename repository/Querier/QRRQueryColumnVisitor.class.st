Class {
	#name : #QRRQueryColumnVisitor,
	#superclass : #QRRQueryEmptyVisitor,
	#category : 'Querier-Queries-Visitors'
}

{ #category : #visiting }
QRRQueryColumnVisitor >> visitDeleteQuery: aQuery with: aStream [
	aQuery joinsDo: [ :join |
		self visit: join with: aStream ].
	
	self visit: aQuery condition with: aStream
]

{ #category : #visiting }
QRRQueryColumnVisitor >> visitInsertQuery: aQuery with: aStream [
	aQuery columnsDo: [ :column |
		self visit: column with: aStream ].
	
	aQuery valuesDo: [ :value |
		self visit: value with: aStream ]
]

{ #category : #visiting }
QRRQueryColumnVisitor >> visitQueryBinaryOperation: aQueryOperation with: aStream [
	self visit: aQueryOperation leftExpression with: aStream.
	self visit: aQueryOperation rightExpression with: aStream
]

{ #category : #visiting }
QRRQueryColumnVisitor >> visitQueryCondition: aQueryCondition with: aStream [
	aQueryCondition conditionsDo: [ :each |
		self visit: each with: aStream ]
]

{ #category : #visiting }
QRRQueryColumnVisitor >> visitQueryGrouping: aQueryGrouping with: aStream [
	aQueryGrouping columnsDo: [ :each |
		self visit: each with: aStream ].
	
	self visit: aQueryGrouping condition with: aStream
]

{ #category : #visiting }
QRRQueryColumnVisitor >> visitQueryJoin: aQueryJoin with: aStream [
	self visit: aQueryJoin condition with: aStream
]

{ #category : #visiting }
QRRQueryColumnVisitor >> visitQueryOrdering: aQueryOrdering with: aStream [
	aQueryOrdering columnsAndDirectionsDo: [ :column :direction |
		self visit: column with: aStream ]
]

{ #category : #visiting }
QRRQueryColumnVisitor >> visitSelectQuery: aQuery with: aStream [
	aQuery columnsDo: [ :column |
		self visit: column with: aStream ].
	
	aQuery joinsDo: [ :join |
		self visit: join with: aStream ].
	
	self visit: aQuery condition with: aStream.
	self visit: aQuery grouping with: aStream.
	self visit: aQuery ordering with: aStream
]

{ #category : #visiting }
QRRQueryColumnVisitor >> visitUpdateQuery: aQuery with: aStream [
	aQuery columnsAndValuesDo: [ :column :value |
		self visit: column with: aStream ].
	
	aQuery joinsDo: [ :join |
		self visit: join with: aStream ].
	
	self visit: aQuery condition with: aStream
]
