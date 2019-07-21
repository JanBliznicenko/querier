Trait {
	#name : #QRRTBasicQueryExpression,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #'expression building' }
QRRTBasicQueryExpression >> * anObject [
	^ QRRQueryMultiplicationOperation left: self right: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRTBasicQueryExpression >> + anObject [
	^ QRRQueryAdditionOperation left: self right: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRTBasicQueryExpression >> - anObject [
	^ QRRQuerySubtractionOperation left: self right: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRTBasicQueryExpression >> / anObject [
	^ QRRQueryDivisionOperation left: self right: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRTBasicQueryExpression >> < anObject [
	^ QRRQueryLessThanComparison left: self right: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRTBasicQueryExpression >> <= anObject [
	^ QRRQueryLessThanOrEqualComparison left: self right: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRTBasicQueryExpression >> = anObject [
	| object |
	object := anObject asQuerierExpression.
	object asQuerierExpression value = 'NULL'
		ifTrue: [ ^ QRRQueryIsNullOperation expression: self ].
	^ QRRQueryEqualComparison
		left: self
		right: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRTBasicQueryExpression >> > anObject [
	^ QRRQueryMoreThanComparison left: self right: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRTBasicQueryExpression >> >= anObject [
	^ QRRQueryMoreThanOrEqualComparison left: self right: anObject asQuerierExpression
]

{ #category : #converting }
QRRTBasicQueryExpression >> adaptToFloat: aNumber andCompare: selector [
	^ self convertToConstant: aNumber andSend: selector
]

{ #category : #converting }
QRRTBasicQueryExpression >> adaptToFloat: aNumber andSend: selector [
	^ self convertToConstant: aNumber andSend: selector
]

{ #category : #converting }
QRRTBasicQueryExpression >> adaptToFraction: aNumber andCompare: selector [
	^ self convertToConstant: aNumber andSend: selector
]

{ #category : #converting }
QRRTBasicQueryExpression >> adaptToFraction: aNumber andSend: selector [
	^ self convertToConstant: aNumber andSend: selector
]

{ #category : #converting }
QRRTBasicQueryExpression >> adaptToInteger: aNumber andCompare: selector [
	^ self convertToConstant: aNumber andSend: selector
]

{ #category : #converting }
QRRTBasicQueryExpression >> adaptToInteger: aNumber andSend: selector [
	^ self convertToConstant: aNumber andSend: selector
]

{ #category : #'expression building' }
QRRTBasicQueryExpression >> asLowercase [
	self inFunction: #lower
]

{ #category : #converting }
QRRTBasicQueryExpression >> asQuerierExpression [
	^ self
]

{ #category : #'expression building' }
QRRTBasicQueryExpression >> asUppercase [
	self inFunction: #upper
]

{ #category : #'expression building' }
QRRTBasicQueryExpression >> between: anObject and: anotherObject [
	^ QRRQueryAndCondition
		with: self >= anObject
		with: self <= anotherObject
]

{ #category : #converting }
QRRTBasicQueryExpression >> convertToConstant: anObject andSend: selector [
	^ anObject asQuerierExpression perform: selector with: self
]

{ #category : #'expression building' }
QRRTBasicQueryExpression >> exists: anObject [
	^ QRRQueryExistenceOperation left: self right: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRTBasicQueryExpression >> ilike: aString [
	^ QRRQueryILikeOperation left: self right: aString asQuerierExpression
]

{ #category : #'expression building' }
QRRTBasicQueryExpression >> in: anObject [
	^ QRRQueryInclusionOperation left: self right: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRTBasicQueryExpression >> inFunction: aString [
	^ QRRQueryUnaryCustomFunction expression: self function: aString
]

{ #category : #'expression building' }
QRRTBasicQueryExpression >> isEmpty: anObject [
	^ self notExists: anObject
]

{ #category : #'expression building' }
QRRTBasicQueryExpression >> isNotNull [
	^ QRRQueryIsNotNullOperation expression: self
]

{ #category : #'expression building' }
QRRTBasicQueryExpression >> isNull [
	^ QRRQueryIsNullOperation expression: self
]

{ #category : #'expression building' }
QRRTBasicQueryExpression >> like: aString [
	^ QRRQueryLikeOperation left: self right: aString asQuerierExpression
]

{ #category : #'expression building' }
QRRTBasicQueryExpression >> not [
	^ QRRQueryNotOperation expression: self
]

{ #category : #'expression building' }
QRRTBasicQueryExpression >> notEmpty: anObject [
	^ self exists: anObject
]

{ #category : #'expression building' }
QRRTBasicQueryExpression >> notExists: anObject [
	^ QRRQueryNonExistenceOperation left: self right: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRTBasicQueryExpression >> notIn: anObject [
	^ QRRQueryNonInclusionOperation left: self right: anObject asQuerierExpression
]

{ #category : #'expression building' }
QRRTBasicQueryExpression >> ~= anObject [
	| object |
	object := anObject asQuerierExpression.
	object asQuerierExpression value = 'NULL'
		ifTrue: [ ^ QRRQueryIsNotNullOperation expression: self ].
	^ QRRQueryNotEqualComparison
		left: self
		right: anObject asQuerierExpression
]
