Class {
	#name : #QRRQueryArithmeticOperation,
	#superclass : #QRRQueryBinaryOperation,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryArithmeticOperation >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryArithmeticOperation: self with: anObject
]
