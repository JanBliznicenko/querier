Class {
	#name : #QRRQueryAdditionOperation,
	#superclass : #QRRQueryArithmeticOperation,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryAdditionOperation >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryAdditionOperation: self with: anObject
]

{ #category : #constants }
QRRQueryAdditionOperation >> operatorSymbol [
	^ #+
]
