Class {
	#name : #QRRResultRow,
	#superclass : #QRRAccessorObject,
	#instVars : [
		'result',
		'values',
		'referencedRows',
		'modifiedColumns',
		'exists'
	],
	#category : 'Querier-Result'
}

{ #category : #'instance creation' }
QRRResultRow class >> result: aResult [
	^ self result: aResult values: Dictionary new exists: false
]

{ #category : #'instance creation' }
QRRResultRow class >> result: aResult values: aDictionary exists: aBoolean [
	^ self new
		result: aResult values: aDictionary exists: aBoolean
]

{ #category : #api }
QRRResultRow >> asDictionary [
	referencedRows
		ifNotNil: [ ^ values , referencedRows ]
		ifNil: [ ^ values ]
]

{ #category : #api }
QRRResultRow >> associationsSelect: aBlock [
	^ self asDictionary associationsSelect: aBlock
]

{ #category : #api }
QRRResultRow >> at: key [
	key isArray ifTrue: [
		^ key size = 1
				ifTrue: [ self at: key first ]
				ifFalse: [ (self at: key first) at: key allButFirst ] ].
	
	values at: key ifPresent: [ :value | ^ value ].
	self referencedRowAt: key ifPresent: [ :value | ^ value ].
	
	result keyNotFound: key forValues: values.
	
	"Try again, the result might have lazy-loaded the value or the reference."
	values at: key ifPresent: [ :value | ^ value ].
	self referencedRowAt: key ifPresent: [ :value | ^ value ].
	
	"(KeyNotFound new key: key) signal."
	^ nil
]

{ #category : #api }
QRRResultRow >> at: key put: value [
	self flag: #todo.
	
	key isArray ifTrue: [
		^ key size = 1
				ifTrue: [ self at: key first put: value ]
				ifFalse: [ (self at: key first) at: key allButFirst put: value ] ].
	
	(referencedRows notNil and: [ referencedRows includesKey: key ])
		ifTrue: [
			value = (referencedRows at: key) ifTrue: [
				^ value ].
			
			referencedRows at: key put: value.
			values at: (result referencedColumnFor: key) put: value primaryKeyValue.
			modifiedColumns at: (result referencedColumnFor: key) put: true.
			^ value ].
	
	value = (self at: key) ifTrue: [
		^ value ].
	
	modifiedColumns at: key put: true.
	^ values at: key put: value
]

{ #category : #api }
QRRResultRow >> delete [
	^ result deleteRow: self
]

{ #category : #api }
QRRResultRow >> doesNotUnderstand: aMessage [
	aMessage numArgs = 0
		ifTrue: [
			^ self at: aMessage selector ].
	
	aMessage numArgs = 1
		ifTrue: [
			^ self
					at: aMessage selector allButLast
					put: aMessage argument ].
	
	^ super doesNotUnderstand: aMessage
]

{ #category : #api }
QRRResultRow >> fieldAt: key ifAbsentPut: aBlock [
	^ values at: key ifAbsentPut: aBlock
]

{ #category : #api }
QRRResultRow >> fieldAt: key ifPresent: aBlock [
	^ values at: key ifPresent: aBlock
]

{ #category : #initialization }
QRRResultRow >> initialize [
	super initialize.
	
	exists := false.
	modifiedColumns := IdentityDictionary new
]

{ #category : #api }
QRRResultRow >> primaryKeyValue [
	^ result primaryKeyForRow: values
]

{ #category : #api }
QRRResultRow >> referencedRowAt: key ifAbsent: aBlock [
	referencedRows ifNil: [ ^ aBlock value ].
	
	^ referencedRows at: key ifAbsent: aBlock
]

{ #category : #api }
QRRResultRow >> referencedRowAt: key ifPresent: aBlock [
	referencedRows ifNil: [ ^ nil ].
	
	^ referencedRows at: key ifPresent: aBlock
]

{ #category : #api }
QRRResultRow >> referencedRowAt: key put: aRow [
	referencedRows ifNil: [ referencedRows := Dictionary new ].
	
	^ referencedRows at: key put: aRow
]

{ #category : #api }
QRRResultRow >> remove [
	^ self delete
]

{ #category : #private }
QRRResultRow >> result: aResult values: aDictionary exists: aBoolean [
	result := aResult.
	values := aDictionary.
	exists := aBoolean
]

{ #category : #api }
QRRResultRow >> save [
	exists
		ifTrue: [ ^ result saveRow: self withColumns: modifiedColumns keys ]
		ifFalse: [ ^ result insertRow: self ]
]
