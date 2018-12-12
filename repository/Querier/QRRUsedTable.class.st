Class {
	#name : #QRRUsedTable,
	#superclass : #Object,
	#instVars : [
		'table',
		'alias'
	],
	#category : 'Querier-Result'
}

{ #category : #'instance creation' }
QRRUsedTable class >> table: tableString [
	^ self new
		table: tableString;
		alias: tableString
]

{ #category : #'instance creation' }
QRRUsedTable class >> table: tableString alias: aliasString [
	^ self new
		table: tableString;
		alias: aliasString
]

{ #category : #accessing }
QRRUsedTable >> alias [
	^ alias
]

{ #category : #accessing }
QRRUsedTable >> alias: anObject [
	alias := anObject
]

{ #category : #accessing }
QRRUsedTable >> table [
	^ table
]

{ #category : #accessing }
QRRUsedTable >> table: anObject [
	table := anObject
]
