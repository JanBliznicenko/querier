Class {
	#name : #QRRInvalidModification,
	#superclass : #Error,
	#instVars : [
		'table'
	],
	#category : 'Querier-Result'
}

{ #category : #accessing }
QRRInvalidModification >> table [
	^ table
]

{ #category : #accessing }
QRRInvalidModification >> table: anObject [
	table := anObject
]
