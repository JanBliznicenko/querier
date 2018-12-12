Class {
	#name : #QRRQueryIdentifier,
	#superclass : #QRRQueryLiteral,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryIdentifier >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryIdentifier: self with: anObject
]
