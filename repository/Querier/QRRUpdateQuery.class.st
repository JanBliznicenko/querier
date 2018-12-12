Class {
	#name : #QRRUpdateQuery,
	#superclass : #QRRQuery,
	#instVars : [
		'columnsAndValues',
		'condition'
	],
	#category : 'Querier-Queries'
}

{ #category : #visiting }
QRRUpdateQuery >> accept: aVisitor with: anObject [
	^ aVisitor visitUpdateQuery: self with: anObject
]

{ #category : #accessing }
QRRUpdateQuery >> addColumn: aColumn value: value [
	columnsAndValues add: aColumn -> value asQuerierExpression
]

{ #category : #accessing }
QRRUpdateQuery >> addCondition: aCondition [
	condition addCondition: aCondition
]

{ #category : #enumerating }
QRRUpdateQuery >> columnsAndValuesDo: twoParameterBlock [
	self columnsAndValuesDo: twoParameterBlock separatedBy: []
]

{ #category : #enumerating }
QRRUpdateQuery >> columnsAndValuesDo: twoParameterBlock separatedBy: separatorBlock [
	columnsAndValues
		do: [ :each |
			twoParameterBlock value: each key value: each value ]
		separatedBy: separatorBlock
]

{ #category : #accessing }
QRRUpdateQuery >> condition [
	^ condition
]

{ #category : #copying }
QRRUpdateQuery >> copyConditionFrom: aQuery [
	condition := aQuery condition
]

{ #category : #initialization }
QRRUpdateQuery >> initialize [
	super initialize.
	
	columnsAndValues := OrderedCollection new.
	condition := QRRQueryAndCondition new
]
