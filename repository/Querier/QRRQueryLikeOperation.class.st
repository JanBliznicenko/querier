Class {
	#name : #QRRQueryLikeOperation,
	#superclass : #QRRQueryBinaryOperation,
	#category : #'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryLikeOperation >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryLikeOperation: self with: anObject
]

{ #category : #constants }
QRRQueryLikeOperation >> operatorSymbol [
	^ #LIKE
]
