Class {
	#name : #QRRSelectQuery,
	#superclass : #QRRQuery,
	#instVars : [
		'columns',
		'condition',
		'grouping',
		'ordering',
		'limit',
		'joins'
	],
	#category : 'Querier-Queries'
}

{ #category : #visiting }
QRRSelectQuery >> accept: aVisitor with: anObject [
	^ aVisitor visitSelectQuery: self with: anObject
]

{ #category : #accessing }
QRRSelectQuery >> addColumn: aQueryColumn [
	columns add: aQueryColumn
]

{ #category : #accessing }
QRRSelectQuery >> addCondition: aCondition [
	condition addCondition: aCondition
]

{ #category : #accessing }
QRRSelectQuery >> addJoin: aQueryJoin [
	joins add: aQueryJoin
]

{ #category : #enumerating }
QRRSelectQuery >> columnsDo: aBlock [
	columns do: aBlock
]

{ #category : #enumerating }
QRRSelectQuery >> columnsDo: aBlock separatedBy: separatorBlock [
	columns do: aBlock separatedBy: separatorBlock
]

{ #category : #accessing }
QRRSelectQuery >> condition [
	^ condition
]

{ #category : #copying }
QRRSelectQuery >> copyConditionFrom: aQuery [
	condition := aQuery condition
]

{ #category : #copying }
QRRSelectQuery >> copyGroupingFrom: aQuery [
	grouping := aQuery grouping
]

{ #category : #copying }
QRRSelectQuery >> copyJoinsFrom: aQuery [
	aQuery joinsDo: [ :each |
		self addJoin: each ]
]

{ #category : #accessing }
QRRSelectQuery >> grouping [
	^ grouping
]

{ #category : #initialization }
QRRSelectQuery >> initialize [
	super initialize.
	
	columns := OrderedCollection new.
	condition := QRRQueryAndCondition new.
	grouping := QRRQueryGrouping new.
	ordering := QRRQueryOrdering new.
	limit := QRRQueryLimit new.
	joins := OrderedCollection new
]

{ #category : #enumerating }
QRRSelectQuery >> joinsDo: aBlock [
	joins do: aBlock
]

{ #category : #accessing }
QRRSelectQuery >> limit [
	^ limit
]

{ #category : #accessing }
QRRSelectQuery >> ordering [
	^ ordering
]
