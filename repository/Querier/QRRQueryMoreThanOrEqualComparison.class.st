Class {
	#name : #QRRQueryMoreThanOrEqualComparison,
	#superclass : #QRRQueryComparison,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryMoreThanOrEqualComparison >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryMoreThanOrEqualComparison: self with: anObject
]

{ #category : #constants }
QRRQueryMoreThanOrEqualComparison >> operatorSymbol [
	^ #>=
]
