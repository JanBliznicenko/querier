Class {
	#name : #QRRQuerier,
	#superclass : #QRRAccessorObject,
	#instVars : [
		'structure',
		'rowMapping',
		'cache',
		'driver'
	],
	#category : 'Querier-Core'
}

{ #category : #'query execution' }
QRRQuerier >> buildQueryStringFrom: aQuery [
	^ driver buildQueryStringFrom: aQuery
]

{ #category : #accessing }
QRRQuerier >> cache: anObject [
	cache := anObject
]

{ #category : #api }
QRRQuerier >> doesNotUnderstand: aMessage [
	aMessage numArgs = 0
		ifTrue: [
			^ self table: aMessage selector ].
	
	aMessage numArgs = 1
		ifTrue: [
			^ (self table: aMessage selector allButLast asSymbol)
					select: aMessage argument ].
	
	^ super doesNotUnderstand: aMessage
]

{ #category : #accessing }
QRRQuerier >> driver: anObject [
	driver := anObject
]

{ #category : #'query execution' }
QRRQuerier >> executeQuery: aQuery [
	^ driver executeQuery: aQuery
]

{ #category : #initialization }
QRRQuerier >> initialize [
	super initialize.
	
	structure := QRRConventionalStructure new.
	rowMapping := QRRBasicRowMapping new
]

{ #category : #accessing }
QRRQuerier >> rowMapping: aRowMapping [
	rowMapping := aRowMapping
]

{ #category : #accessing }
QRRQuerier >> structure: anObject [
	structure := anObject
]

{ #category : #api }
QRRQuerier >> table: nameString [
	^ QRRResult table: nameString querier: self structure: structure rowMapping: rowMapping
]
