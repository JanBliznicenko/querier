Class {
	#name : #QRRQueryOrdering,
	#superclass : #QRRQueryPart,
	#instVars : [
		'columnsAndDirections'
	],
	#category : 'Querier-Queries'
}

{ #category : #visiting }
QRRQueryOrdering >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryOrdering: self with: anObject
]

{ #category : #accessing }
QRRQueryOrdering >> addAscendingColumn: aColumn [
	columnsAndDirections add: (Association key: aColumn value: #ascending)
]

{ #category : #accessing }
QRRQueryOrdering >> addColumn: aColumn [
	self addAscendingColumn: aColumn
]

{ #category : #accessing }
QRRQueryOrdering >> addDescendingColumn: aColumn [
	columnsAndDirections add: (Association key: aColumn value: #descending)
]

{ #category : #enumerating }
QRRQueryOrdering >> columnsAndDirectionsDo: twoArgumentBlock [
	self columnsAndDirectionsDo: twoArgumentBlock separatedBy: []
]

{ #category : #enumerating }
QRRQueryOrdering >> columnsAndDirectionsDo: twoArgumentBlock separatedBy: separatorBlock [
	columnsAndDirections
		do: [ :each |
			twoArgumentBlock value: each key value: each value ]
		separatedBy: separatorBlock
]

{ #category : #initialization }
QRRQueryOrdering >> initialize [
	super initialize.
	
	columnsAndDirections := OrderedCollection new
]

{ #category : #testing }
QRRQueryOrdering >> isEmpty [
	^ columnsAndDirections isEmpty
]
