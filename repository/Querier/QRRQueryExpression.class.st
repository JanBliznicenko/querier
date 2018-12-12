Class {
	#name : #QRRQueryExpression,
	#superclass : #Object,
	#traits : 'QRRTBasicQueryExpression',
	#classTraits : 'QRRTBasicQueryExpression classTrait',
	#category : 'Querier-Queries-Expressions'
}

{ #category : #'expression building' }
QRRQueryExpression >> * anObject [
	^ QRRQueryMultiplicationOperation left: self right: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRQueryExpression >> + anObject [
	^ QRRQueryAdditionOperation left: self right: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRQueryExpression >> - anObject [
	^ QRRQuerySubtractionOperation left: self right: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRQueryExpression >> / anObject [
	^ QRRQueryDivisionOperation left: self right: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRQueryExpression >> < anObject [
	^ QRRQueryLessThanComparison left: self right: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRQueryExpression >> <= anObject [
	^ QRRQueryLessThanOrEqualComparison left: self right: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRQueryExpression >> = anObject [
	^ QRRQueryEqualComparison left: self right: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRQueryExpression >> > anObject [
	^ QRRQueryMoreThanComparison left: self right: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRQueryExpression >> >= anObject [
	^ QRRQueryMoreThanOrEqualComparison left: self right: anObject asQuerierExpression
]

{ #category : #visiting }
QRRQueryExpression >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryExpression: self with: anObject
]

{ #category : #converting }
QRRQueryExpression >> adaptToFloat: aNumber andCompare: selector [
	^ self convertToConstant: aNumber andSend: selector
]

{ #category : #converting }
QRRQueryExpression >> adaptToFloat: aNumber andSend: selector [
	^ self convertToConstant: aNumber andSend: selector
]

{ #category : #converting }
QRRQueryExpression >> adaptToFraction: aNumber andCompare: selector [
	^ self convertToConstant: aNumber andSend: selector
]

{ #category : #converting }
QRRQueryExpression >> adaptToFraction: aNumber andSend: selector [
	^ self convertToConstant: aNumber andSend: selector
]

{ #category : #converting }
QRRQueryExpression >> adaptToInteger: aNumber andCompare: selector [
	^ self convertToConstant: aNumber andSend: selector
]

{ #category : #converting }
QRRQueryExpression >> adaptToInteger: aNumber andSend: selector [
	^ self convertToConstant: aNumber andSend: selector
]

{ #category : #converting }
QRRQueryExpression >> asQuerierExpression [
	^ self
]

{ #category : #converting }
QRRQueryExpression >> convertToConstant: anObject andSend: selector [
	^ anObject asQuerierExpression perform: selector with: self
]

{ #category : #'expression building' }
QRRQueryExpression >> in: anObject [
	^ QRRQueryInclusionOperation left: self right: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRQueryExpression >> ~= anObject [
	^ QRRQueryNotEqualComparison left: self right: anObject asQuerierExpression
]
