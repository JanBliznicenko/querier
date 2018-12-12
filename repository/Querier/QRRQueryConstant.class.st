Class {
	#name : #QRRQueryConstant,
	#superclass : #QRRQueryLiteral,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryConstant >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryConstant: self with: anObject
]
