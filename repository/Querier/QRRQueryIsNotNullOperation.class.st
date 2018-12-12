Class {
	#name : #QRRQueryIsNotNullOperation,
	#superclass : #QRRQueryUnaryOperation,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryIsNotNullOperation >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryIsNotNullOperation: self with: anObject
]
