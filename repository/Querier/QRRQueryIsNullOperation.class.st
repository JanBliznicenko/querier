Class {
	#name : #QRRQueryIsNullOperation,
	#superclass : #QRRQueryUnaryOperation,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryIsNullOperation >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryIsNullOperation: self with: anObject
]
