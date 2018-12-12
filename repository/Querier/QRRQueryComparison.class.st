Class {
	#name : #QRRQueryComparison,
	#superclass : #QRRQueryBinaryOperation,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryComparison >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryComparison: self with: anObject
]
