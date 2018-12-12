Class {
	#name : #QRRQueryLessThanOrEqualComparison,
	#superclass : #QRRQueryComparison,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryLessThanOrEqualComparison >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryLessThanOrEqualComparison: self with: anObject
]

{ #category : #constants }
QRRQueryLessThanOrEqualComparison >> operatorSymbol [
	^ #<=
]
