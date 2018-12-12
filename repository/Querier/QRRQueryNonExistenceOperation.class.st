Class {
	#name : #QRRQueryNonExistenceOperation,
	#superclass : #QRRQueryBinaryOperation,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryNonExistenceOperation >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryNonExistenceOperation: self with: anObject
]

{ #category : #constants }
QRRQueryNonExistenceOperation >> operatorSymbol [
	^ nil
]
