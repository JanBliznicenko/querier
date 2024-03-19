Class {
	#name : #QRRQueryNonExistenceOperation,
	#superclass : #QRRQueryBinaryOperation,
	#traits : 'QRRTQueryBooleanOperation',
	#classTraits : 'QRRTQueryBooleanOperation classTrait',
	#category : #'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryNonExistenceOperation >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryNonExistenceOperation: self with: anObject
]

{ #category : #constants }
QRRQueryNonExistenceOperation >> operatorSymbol [
	^ nil
]
