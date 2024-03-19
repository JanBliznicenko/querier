Class {
	#name : #QRRQueryLikeOperation,
	#superclass : #QRRQueryBinaryOperation,
	#traits : 'QRRTQueryBooleanOperation',
	#classTraits : 'QRRTQueryBooleanOperation classTrait',
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
