Class {
	#name : #QRRQueryMoreThanComparison,
	#superclass : #QRRQueryComparison,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryMoreThanComparison >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryMoreThanComparison: self with: anObject
]

{ #category : #constants }
QRRQueryMoreThanComparison >> operatorSymbol [
	^ #>
]
