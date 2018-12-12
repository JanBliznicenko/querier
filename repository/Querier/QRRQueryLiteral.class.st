Class {
	#name : #QRRQueryLiteral,
	#superclass : #QRRQueryExpression,
	#instVars : [
		'value'
	],
	#category : 'Querier-Queries-Expressions'
}

{ #category : #'instance creation' }
QRRQueryLiteral class >> with: anObject [
	^ self new
		value: anObject
]

{ #category : #visiting }
QRRQueryLiteral >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryLiteral: self with: anObject
]

{ #category : #accessing }
QRRQueryLiteral >> value [
	^ value
]

{ #category : #private }
QRRQueryLiteral >> value: anObject [
	value := anObject
]
