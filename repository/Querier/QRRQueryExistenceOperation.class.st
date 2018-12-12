Class {
	#name : #QRRQueryExistenceOperation,
	#superclass : #QRRQueryBinaryOperation,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryExistenceOperation >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryExistenceOperation: self with: anObject
]

{ #category : #constants }
QRRQueryExistenceOperation >> operatorSymbol [
	^ nil
]
