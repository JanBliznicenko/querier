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

{ #category : #visiting }
QRRQueryColumn >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryColumn: self with: anObject
]

{ #category : #converting }
QRRQueryColumn >> asExternalColumn [
	^ QRRQueryExternalColumn identifiers: identifiers
]

{ #category : #'expression building' }
QRRQueryColumn >> at: key [
	^ self class identifiers: (identifiers copyWith: key)
]

{ #category : #'expression building' }
QRRQueryColumn >> at: key put: value [
	^ self error: 'This column is not mutable.'
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
