Class {
	#name : #QRRQueryEqualComparison,
	#superclass : #QRRQueryComparison,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryEqualComparison >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryEqualComparison: self with: anObject
]

{ #category : #constants }
QRRQueryEqualComparison >> operatorSymbol [
	^ #=
]
