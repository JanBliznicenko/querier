Class {
	#name : #QRRQueryLimit,
	#superclass : #QRRQueryPart,
	#instVars : [
		'limit',
		'offset'
	],
	#category : 'Querier-Queries'
}

{ #category : #visiting }
QRRQueryLimit >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryLimit: self with: anObject
]

{ #category : #accessing }
QRRQueryLimit >> limit [
	^ limit
]

{ #category : #accessing }
QRRQueryLimit >> limit: anInteger [
	limit := anInteger
]

{ #category : #accessing }
QRRQueryLimit >> offset [
	^ offset
]

{ #category : #accessing }
QRRQueryLimit >> offset: anInteger [
	offset := anInteger
]
