Class {
	#name : #QRRQueryNestedQuery,
	#superclass : #QRRQueryLiteral,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryNestedQuery >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryNestedQuery: self with: anObject
]
