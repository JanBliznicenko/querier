Class {
	#name : #QRRQueryUnaryOperation,
	#superclass : #QRRQueryOperation,
	#instVars : [
		'expression'
	],
	#category : 'Querier-Queries-Expressions'
}

{ #category : #'instance creation' }
QRRQueryUnaryOperation class >> expression: aQueryExpression [
	^ self new
		expression: aQueryExpression
]

{ #category : #visiting }
QRRQueryUnaryOperation >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryUnaryOperation: self with: anObject
]

{ #category : #accessing }
QRRQueryUnaryOperation >> expression [
	^ expression
]

{ #category : #accessing }
QRRQueryUnaryOperation >> expression: anObject [
	expression := anObject
]

{ #category : #enumerating }
QRRQueryUnaryOperation >> expressionsDo: aBlock [
	aBlock value: expression
]

{ #category : #enumerating }
QRRQueryUnaryOperation >> expressionsDo: aBlock separatedBy: separatorBlock [
	aBlock value: expression
]
