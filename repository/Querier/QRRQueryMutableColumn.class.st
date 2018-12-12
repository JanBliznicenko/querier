Class {
	#name : #QRRQueryMutableColumn,
	#superclass : #QRRQueryColumn,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #'expression building' }
QRRQueryMutableColumn >> at: key put: value [
	| column valueExpression |
	
	column := self class identifiers: (identifiers copyWith: key).
	valueExpression := value asQuerierExpression.
	
	QRRModificationNotification signalForColumn: column value: valueExpression.
	
	^ QRRQueryAssignmentOperation
			left: column
			right: valueExpression
]

{ #category : #'expression building' }
QRRQueryMutableColumn >> doesNotUnderstand: aMessage [
	aMessage numArgs = 1
		ifTrue: [
			^ self at: aMessage selector allButLast put: aMessage argument ].
	
	^ super doesNotUnderstand: aMessage
]
