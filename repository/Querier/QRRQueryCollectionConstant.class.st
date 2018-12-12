Class {
	#name : #QRRQueryCollectionConstant,
	#superclass : #QRRQueryConstant,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryCollectionConstant >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryCollectionConstant: self with: anObject
]
