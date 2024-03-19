Class {
	#name : #QRRQueryExistenceOperation,
	#superclass : #QRRQueryBinaryOperation,
	#traits : 'QRRTQueryBooleanOperation',
	#classTraits : 'QRRTQueryBooleanOperation classTrait',
	#category : #'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryExistenceOperation >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryExistenceOperation: self with: anObject
]

{ #category : #constants }
QRRQueryExistenceOperation >> operatorSymbol [
	^ nil
]
