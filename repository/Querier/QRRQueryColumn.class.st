Class {
	#name : #QRRQueryColumn,
	#superclass : #QRRAccessorObject,
	#traits : 'QRRTBasicQueryExpression',
	#classTraits : 'QRRTBasicQueryExpression classTrait',
	#instVars : [
		'identifiers'
	],
	#category : 'Querier-Queries-Expressions'
}

{ #category : #'instance creation' }
QRRQueryColumn class >> identifier: aString [
	^ self identifiers: (Array with: aString)
]

{ #category : #'instance creation' }
QRRQueryColumn class >> identifiers: aCollection [
	^ self new
		qrrSetIdentifiers: aCollection
]

{ #category : #'expression building' }
QRRQueryColumn >> * anObject [
	^ QRRQueryMultiplicationOperation left: self right: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRQueryColumn >> + anObject [
	^ QRRQueryAdditionOperation left: self right: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRQueryColumn >> - anObject [
	^ QRRQuerySubtractionOperation left: self right: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRQueryColumn >> / anObject [
	^ QRRQueryDivisionOperation left: self right: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRQueryColumn >> < anObject [
	^ QRRQueryLessThanComparison left: self right: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRQueryColumn >> <= anObject [
	^ QRRQueryLessThanOrEqualComparison left: self right: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRQueryColumn >> = anObject [
	^ QRRQueryEqualComparison left: self right: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRQueryColumn >> > anObject [
	^ QRRQueryMoreThanComparison left: self right: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRQueryColumn >> >= anObject [
	^ QRRQueryMoreThanOrEqualComparison left: self right: anObject asQuerierExpression
]

{ #category : #visiting }
QRRQueryColumn >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryColumn: self with: anObject
]

{ #category : #converting }
QRRQueryColumn >> adaptToFloat: aNumber andCompare: selector [
	^ self convertToConstant: aNumber andSend: selector
]

{ #category : #converting }
QRRQueryColumn >> adaptToFloat: aNumber andSend: selector [
	^ self convertToConstant: aNumber andSend: selector
]

{ #category : #converting }
QRRQueryColumn >> adaptToFraction: aNumber andCompare: selector [
	^ self convertToConstant: aNumber andSend: selector
]

{ #category : #converting }
QRRQueryColumn >> adaptToFraction: aNumber andSend: selector [
	^ self convertToConstant: aNumber andSend: selector
]

{ #category : #converting }
QRRQueryColumn >> adaptToInteger: aNumber andCompare: selector [
	^ self convertToConstant: aNumber andSend: selector
]

{ #category : #converting }
QRRQueryColumn >> adaptToInteger: aNumber andSend: selector [
	^ self convertToConstant: aNumber andSend: selector
]

{ #category : #converting }
QRRQueryColumn >> asExternalColumn [
	^ QRRQueryExternalColumn identifiers: identifiers
]

{ #category : #converting }
QRRQueryColumn >> asQuerierExpression [
	^ self
]

{ #category : #'expression building' }
QRRQueryColumn >> at: key [
	^ self class identifiers: (identifiers copyWith: key)
]

{ #category : #'expression building' }
QRRQueryColumn >> at: key put: value [
	^ self error: 'This column is not mutable.'
]

{ #category : #converting }
QRRQueryColumn >> convertToConstant: anObject andSend: selector [
	^ anObject asQuerierExpression perform: selector with: self
]

{ #category : #'expression building' }
QRRQueryColumn >> doesNotUnderstand: aMessage [
	aMessage numArgs = 0
		ifTrue: [
			^ self at: aMessage selector ].
	
	^ super doesNotUnderstand: aMessage
]

{ #category : #enumerating }
QRRQueryColumn >> identifiersDo: aBlock separatedBy: separatorBlock [
	identifiers do: aBlock separatedBy: separatorBlock
]

{ #category : #enumerating }
QRRQueryColumn >> ifMoreThan: anInteger identifiersDo: aBlock [
	identifiers size > anInteger
		ifTrue: aBlock
]

{ #category : #'expression building' }
QRRQueryColumn >> ilike: aString [
	^ QRRQueryILikeOperation left: self right: aString asQuerierExpression
]

{ #category : #'expression building' }
QRRQueryColumn >> in: anObject [
	^ QRRQueryInclusionOperation left: self right: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRQueryColumn >> like: aString [
	^ QRRQueryLikeOperation left: self right: aString asQuerierExpression
]

{ #category : #'expression building' }
QRRQueryColumn >> notIn: anObject [
	^ QRRQueryNonInclusionOperation left: self right: anObject asQuerierExpression
]

{ #category : #accessing }
QRRQueryColumn >> qrrGetIdentifiers [
	"Named like this so it does not collide with column names (see #doesNotUnderstand:)."
	^ identifiers
]

{ #category : #accessing }
QRRQueryColumn >> qrrSetIdentifiers: aCollection [
	"Named like this so it does not collide with column names (see #doesNotUnderstand:)."
	identifiers := aCollection
]

{ #category : #'expression building' }
QRRQueryColumn >> ~= anObject [
	^ QRRQueryNotEqualComparison left: self right: anObject asQuerierExpression
]
