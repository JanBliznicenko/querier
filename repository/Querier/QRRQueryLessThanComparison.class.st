Class {
	#name : #QRRQueryLessThanComparison,
	#superclass : #QRRQueryComparison,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryLessThanComparison >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryLessThanComparison: self with: anObject
]

{ #category : #constants }
QRRQueryLessThanComparison >> operatorSymbol [
	^ #<
]
