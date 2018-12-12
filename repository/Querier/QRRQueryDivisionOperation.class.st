Class {
	#name : #QRRQueryDivisionOperation,
	#superclass : #QRRQueryArithmeticOperation,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryDivisionOperation >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryDivisionOperation: self with: anObject
]

{ #category : #constants }
QRRQueryDivisionOperation >> operatorSymbol [
	^ #/
]
