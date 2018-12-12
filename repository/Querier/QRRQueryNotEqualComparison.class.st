Class {
	#name : #QRRQueryNotEqualComparison,
	#superclass : #QRRQueryComparison,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryNotEqualComparison >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryNotEqualComparison: self with: anObject
]

{ #category : #constants }
QRRQueryNotEqualComparison >> operatorSymbol [
	^ #~=
]
