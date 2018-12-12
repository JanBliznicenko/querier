Class {
	#name : #QRRQueryUnaryFunction,
	#superclass : #QRRQueryUnaryOperation,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryUnaryFunction >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryUnaryFunction: self with: anObject
]

{ #category : #constants }
QRRQueryUnaryFunction >> functionName [
	self subclassResponsibility
]
