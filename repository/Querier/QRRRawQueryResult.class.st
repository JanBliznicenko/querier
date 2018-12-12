Class {
	#name : #QRRRawQueryResult,
	#superclass : #Object,
	#category : 'Querier-Drivers'
}

{ #category : #accessing }
QRRRawQueryResult >> affectedRows [
	self subclassResponsibility
]

{ #category : #accessing }
QRRRawQueryResult >> columns [
	self subclassResponsibility
]

{ #category : #enumerating }
QRRRawQueryResult >> rowsDo: aBlock [
	self subclassResponsibility
]
