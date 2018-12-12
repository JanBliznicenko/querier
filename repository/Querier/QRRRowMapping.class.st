Class {
	#name : #QRRRowMapping,
	#superclass : #Object,
	#category : 'Querier-Structure'
}

{ #category : #'creating rows' }
QRRRowMapping >> createExistingRowFor: aDictionary result: aResult [
	self subclassResponsibility
]

{ #category : #'creating rows' }
QRRRowMapping >> createNewRowFor: aDictionary result: aResult [
	self subclassResponsibility
]

{ #category : #events }
QRRRowMapping >> queryExecuted: aResult [
	"Do nothing by default."
]
