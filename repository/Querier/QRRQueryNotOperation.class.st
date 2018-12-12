Class {
	#name : #QRRQueryNotOperation,
	#superclass : #QRRQueryUnaryOperation,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryNotOperation >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryNotOperation: self with: anObject
]
