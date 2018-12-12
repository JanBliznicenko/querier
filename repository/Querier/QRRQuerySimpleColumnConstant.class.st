Class {
	#name : #QRRQuerySimpleColumnConstant,
	#superclass : #QRRQueryExpression,
	#instVars : [
		'identifiers'
	],
	#category : 'Querier-Queries-Expressions'
}

{ #category : #'instance creation' }
QRRQuerySimpleColumnConstant class >> identifiers: aCollection [
	^ self new
		identifiers: aCollection;
		yourself
]

{ #category : #visiting }
QRRQuerySimpleColumnConstant >> accept: aVisitor with: anObject [
	^ aVisitor visitQuerySimpleColumn: self with: anObject
]

{ #category : #accessing }
QRRQuerySimpleColumnConstant >> identifiers [
	^ identifiers
]

{ #category : #accessing }
QRRQuerySimpleColumnConstant >> identifiers: aCollection [
	identifiers := OrderedCollection newFrom: aCollection
]

{ #category : #initialization }
QRRQuerySimpleColumnConstant >> initialize [
	super initialize.
	identifiers := OrderedCollection new
]
