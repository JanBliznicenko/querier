Class {
	#name : #QRRQueryNonInclusionOperation,
	#superclass : #QRRQueryBinaryOperation,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryNonInclusionOperation >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryNonInclusionOperation: self with: anObject
]

{ #category : #constants }
QRRQueryNonInclusionOperation >> operatorSymbol [
	^ nil
]
