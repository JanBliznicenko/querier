Class {
	#name : #QRRQueryAssignmentOperation,
	#superclass : #QRRQueryBinaryOperation,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryAssignmentOperation >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryAssignmentOperation: self with: anObject
]

{ #category : #constants }
QRRQueryAssignmentOperation >> operatorSymbol [
	^ #':='
]
