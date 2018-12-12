Class {
	#name : #QRRQueryNumberConstant,
	#superclass : #QRRQueryConstant,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryNumberConstant >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryNumberConstant: self with: anObject
]
