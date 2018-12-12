Class {
	#name : #QRRInsertQuery,
	#superclass : #QRRQuery,
	#instVars : [
		'columnsAndValues',
		'returnRow'
	],
	#category : 'Querier-Queries'
}

{ #category : #visiting }
QRRInsertQuery >> accept: aVisitor with: anObject [
	^ aVisitor visitInsertQuery: self with: anObject
]

{ #category : #accessing }
QRRInsertQuery >> addColumnsAndValues: aDictionary [
	^ columnsAndValues addAll: aDictionary
]

{ #category : #enumerating }
QRRInsertQuery >> columns [
	^ columnsAndValues collect: [ :each | each key ]
]

{ #category : #enumerating }
QRRInsertQuery >> columnsAndValuesDo: twoParameterBlock [
	self columnsAndValuesDo: twoParameterBlock separatedBy: []
]

{ #category : #enumerating }
QRRInsertQuery >> columnsAndValuesDo: twoParameterBlock separatedBy: separatorBlock [
	columnsAndValues
		do: [ :each |
			twoParameterBlock value: each key value: each value ]
		separatedBy: separatorBlock
]

{ #category : #enumerating }
QRRInsertQuery >> columnsDo: aBlock [
	self columns do: aBlock
]

{ #category : #enumerating }
QRRInsertQuery >> columnsDo: aBlock separatedBy: separatorBlock [
	self columns do: aBlock separatedBy: separatorBlock
]

{ #category : #initialization }
QRRInsertQuery >> initialize [
	super initialize.
	
	columnsAndValues := Dictionary new.
	returnRow := false
]

{ #category : #accessing }
QRRInsertQuery >> returnRow [
	^ returnRow
]

{ #category : #accessing }
QRRInsertQuery >> returnRow: anObject [
	returnRow := anObject
]

{ #category : #enumerating }
QRRInsertQuery >> values [
	^ columnsAndValues collect: [ :each | each value ]
]

{ #category : #enumerating }
QRRInsertQuery >> valuesDo: aBlock [
	self values do: aBlock
]

{ #category : #enumerating }
QRRInsertQuery >> valuesDo: aBlock separatedBy: separatorBlock [
	self values do: aBlock separatedBy: separatorBlock
]
