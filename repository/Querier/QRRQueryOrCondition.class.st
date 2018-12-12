Class {
	#name : #QRRQueryOrCondition,
	#superclass : #QRRQueryCondition,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryOrCondition >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryOrCondition: self with: anObject
]

{ #category : #'expression building' }
QRRQueryOrCondition >> | anObject [
	self addCondition: anObject asQuerierExpression.
	^ self
]
