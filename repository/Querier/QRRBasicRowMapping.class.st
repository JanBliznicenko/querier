Class {
	#name : #QRRBasicRowMapping,
	#superclass : #QRRRowMapping,
	#category : 'Querier-Structure'
}

{ #category : #'creating rows' }
QRRBasicRowMapping >> createExistingRowFor: aDictionary result: aResult [
	^ self createRowFor: aDictionary result: aResult exists: true
]

{ #category : #'creating rows' }
QRRBasicRowMapping >> createNewRowFor: aDictionary result: aResult [
	^ self createRowFor: aDictionary result: aResult exists: false
]

{ #category : #'creating rows' }
QRRBasicRowMapping >> createRowFor: aDictionary result: aResult exists: aBoolean [
	^ QRRResultRow result: aResult values: aDictionary exists: aBoolean
]
