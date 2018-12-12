Class {
	#name : #QRRQueryDistinctOperation,
	#superclass : #QRRQueryUnaryOperation,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryDistinctOperation >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryDistinctOperation: self with: anObject
]
