Class {
	#name : #QRRQueryOperation,
	#superclass : #QRRQueryExpression,
	#category : #'Querier-Queries-Expressions'
}

{ #category : #'expression building' }
QRRQueryOperation >> & anObject [
	^ QRRQueryAndCondition with: self with: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRQueryOperation >> && anObject [
	^ self & anObject
]

{ #category : #visiting }
QRRQueryOperation >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryOperation: self with: anObject
]

{ #category : #'expression building' }
QRRQueryOperation >> | anObject [
	^ QRRQueryOrCondition with: self with: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRQueryOperation >> || anObject [
	^ self | anObject
]
