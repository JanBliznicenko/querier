Class {
	#name : #QRRDeleteQuery,
	#superclass : #QRRQuery,
	#instVars : [
		'condition'
	],
	#category : 'Querier-Queries'
}

{ #category : #visiting }
QRRDeleteQuery >> accept: aVisitor with: anObject [
	^ aVisitor visitDeleteQuery: self with: anObject
]

{ #category : #accessing }
QRRDeleteQuery >> addCondition: aCondition [
	condition addCondition: aCondition
]

{ #category : #accessing }
QRRDeleteQuery >> condition [
	^ condition
]

{ #category : #copying }
QRRDeleteQuery >> copyConditionFrom: aQuery [
	condition := aQuery condition
]

{ #category : #initialization }
QRRDeleteQuery >> initialize [
	super initialize.
	
	condition := QRRQueryAndCondition new
]
