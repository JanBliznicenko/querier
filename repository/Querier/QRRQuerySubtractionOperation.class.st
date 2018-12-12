Class {
	#name : #QRRQuerySubtractionOperation,
	#superclass : #QRRQueryArithmeticOperation,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQuerySubtractionOperation >> accept: aVisitor with: anObject [
	^ aVisitor visitQuerySubtractionOperation: self with: anObject
]

{ #category : #constants }
QRRQuerySubtractionOperation >> operatorSymbol [
	^ #-
]
