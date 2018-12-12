Class {
	#name : #QRRQueryLogger,
	#superclass : #Object,
	#category : 'Querier-Logging'
}

{ #category : #api }
QRRQueryLogger >> log: queryString [
	self subclassResponsibility
]
