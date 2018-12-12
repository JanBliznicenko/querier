Class {
	#name : #QRRQueryMultiplicationOperation,
	#superclass : #QRRQueryArithmeticOperation,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryMultiplicationOperation >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryMultiplicationOperation: self with: anObject
]

{ #category : #constants }
QRRQueryMultiplicationOperation >> operatorSymbol [
	^ #*
]
