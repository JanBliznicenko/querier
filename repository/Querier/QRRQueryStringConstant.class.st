Class {
	#name : #QRRQueryStringConstant,
	#superclass : #QRRQueryConstant,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryStringConstant >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryStringConstant: self with: anObject
]
