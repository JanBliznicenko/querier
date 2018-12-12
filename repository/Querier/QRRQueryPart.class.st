Class {
	#name : #QRRQueryPart,
	#superclass : #Object,
	#category : 'Querier-Queries'
}

{ #category : #visiting }
QRRQueryPart >> accept: aVisitor with: anObject [
	self subclassResponsibility
]
