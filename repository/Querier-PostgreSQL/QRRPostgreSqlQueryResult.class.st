Class {
	#name : #QRRPostgreSqlQueryResult,
	#superclass : #QRRRawQueryResult,
	#instVars : [
		'driver',
		'queryString',
		'columns'
	],
	#category : 'Querier-PostgreSQL'
}

{ #category : #'instance creation' }
QRRPostgreSqlQueryResult class >> driver: aDriver query: queryString [
	^ self new
		driver: aDriver;
		queryString: queryString
]

{ #category : #accessing }
QRRPostgreSqlQueryResult >> affectedRows [
	^ driver executeAndReturnAffectedRows: queryString
]

{ #category : #accessing }
QRRPostgreSqlQueryResult >> columns [
	^ columns
]

{ #category : #private }
QRRPostgreSqlQueryResult >> driver: anObject [
	driver := anObject
]

{ #category : #private }
QRRPostgreSqlQueryResult >> queryString: anObject [
	queryString := anObject
]

{ #category : #enumerating }
QRRPostgreSqlQueryResult >> rowsDo: aBlock [
	columns := driver execute: queryString rowsDo: aBlock
]
