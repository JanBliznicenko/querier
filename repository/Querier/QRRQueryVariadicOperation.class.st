Class {
	#name : #QRRQueryVariadicOperation,
	#superclass : #QRRQueryOperation,
	#instVars : [
		'expressions'
	],
	#category : 'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryVariadicOperation >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryVariadicOperation: self with: anObject
]

{ #category : #enumerating }
QRRQueryVariadicOperation >> expressionsDo: aBlock [
	expressions do: aBlock
]

{ #category : #enumerating }
QRRQueryVariadicOperation >> expressionsDo: aBlock separatedBy: separatorBlock [
	expressions do: aBlock separatedBy: separatorBlock
]
