Class {
	#name : #QRRPostgreSql2QueryResult,
	#superclass : #QRRRawQueryResult,
	#instVars : [
		'driver',
		'queryString',
		'columns'
	],
	#category : #'Querier-PostgreSQLv2'
}

{ #category : #'instance creation' }
QRRPostgreSql2QueryResult class >> driver: aDriver query: queryString [
	^ self new
		driver: aDriver;
		queryString: queryString
]

{ #category : #accessing }
QRRPostgreSql2QueryResult >> affectedRows [
	^ driver executeAndReturnAffectedRows: queryString
]

{ #category : #accessing }
QRRPostgreSql2QueryResult >> columns [
	^ columns
]

{ #category : #private }
QRRPostgreSql2QueryResult >> driver: anObject [
	driver := anObject
]

{ #category : #private }
QRRPostgreSql2QueryResult >> queryString: anObject [
	queryString := anObject
]

{ #category : #enumerating }
QRRPostgreSql2QueryResult >> rowsDo: aBlock [
	columns := driver execute: queryString rowsDo: aBlock
]
