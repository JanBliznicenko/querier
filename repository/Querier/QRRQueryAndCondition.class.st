Class {
	#name : #QRRQueryAndCondition,
	#superclass : #QRRQueryCondition,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #'expression building' }
QRRQueryAndCondition >> & anObject [
	self addCondition: anObject asQuerierExpression.
	^ self
]

{ #category : #visiting }
QRRQueryAndCondition >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryAndCondition: self with: anObject
]
