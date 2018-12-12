Class {
	#name : #QRRQueryBinaryOperation,
	#superclass : #QRRQueryOperation,
	#instVars : [
		'left',
		'right'
	],
	#category : 'Querier-Queries-Expressions'
}

{ #category : #'instance creation' }
QRRQueryBinaryOperation class >> left: leftExpression right: rightExpression [
	^ self new
		left: leftExpression right: rightExpression
]

{ #category : #visiting }
QRRQueryBinaryOperation >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryBinaryOperation: self with: anObject
]

{ #category : #enumerating }
QRRQueryBinaryOperation >> expressionsDo: aBlock [
	self expressionsDo: aBlock separatedBy: []
]

{ #category : #enumerating }
QRRQueryBinaryOperation >> expressionsDo: aBlock separatedBy: separatorBlock [
	aBlock value: left.
	separatorBlock value.
	aBlock value: right
]

{ #category : #private }
QRRQueryBinaryOperation >> left: leftExpression right: rightExpression [

	left := leftExpression.
	right := rightExpression
]

{ #category : #accessing }
QRRQueryBinaryOperation >> leftExpression [
	^ left
]

{ #category : #constants }
QRRQueryBinaryOperation >> operatorSymbol [
	self subclassResponsibility
]

{ #category : #accessing }
QRRQueryBinaryOperation >> rightExpression [
	^ right
]
