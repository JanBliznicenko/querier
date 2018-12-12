Class {
	#name : #QRRQuery,
	#superclass : #Object,
	#instVars : [
		'table'
	],
	#category : 'Querier-Queries'
}

{ #category : #visiting }
QRRQuery >> accept: aVisitor with: anObject [
	^ aVisitor visitQuery: self with: anObject
]

{ #category : #accessing }
QRRQuery >> table [
	^ table
]

{ #category : #accessing }
QRRQuery >> table: anObject [
	table := anObject
]
