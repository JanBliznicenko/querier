Class {
	#name : #QRRQueryJoin,
	#superclass : #QRRQueryPart,
	#instVars : [
		'table',
		'alias',
		'condition'
	],
	#category : 'Querier-Queries'
}

{ #category : #visiting }
QRRQueryJoin >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryJoin: self with: anObject
]

{ #category : #accessing }
QRRQueryJoin >> alias [
	^ alias ifNil: [ self table ]
]

{ #category : #accessing }
QRRQueryJoin >> alias: anObject [
	alias := anObject
]

{ #category : #accessing }
QRRQueryJoin >> condition [
	^ condition
]

{ #category : #accessing }
QRRQueryJoin >> condition: anObject [
	condition := anObject
]

{ #category : #accessing }
QRRQueryJoin >> table [
	^ table
]

{ #category : #accessing }
QRRQueryJoin >> table: anObject [
	table := anObject
]
