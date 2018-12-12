Class {
	#name : #QRRQueryGrouping,
	#superclass : #QRRQueryPart,
	#instVars : [
		'columns',
		'condition'
	],
	#category : 'Querier-Queries'
}

{ #category : #visiting }
QRRQueryGrouping >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryGrouping: self with: anObject
]

{ #category : #accessing }
QRRQueryGrouping >> addColumn: aColumn [
	columns add: aColumn
]

{ #category : #accessing }
QRRQueryGrouping >> addCondition: aCondition [
	condition addCondition: aCondition
]

{ #category : #enumerating }
QRRQueryGrouping >> columnsDo: aBlock [
	columns do: aBlock
]

{ #category : #enumerating }
QRRQueryGrouping >> columnsDo: aBlock separatedBy: separatorBlock [
	columns do: aBlock separatedBy: separatorBlock
]

{ #category : #accessing }
QRRQueryGrouping >> condition [
	^ condition
]

{ #category : #initialization }
QRRQueryGrouping >> initialize [
	super initialize.
	
	columns := OrderedCollection new.
	condition := QRRQueryAndCondition new
]

{ #category : #testing }
QRRQueryGrouping >> isEmpty [
	^ columns isEmpty
]
