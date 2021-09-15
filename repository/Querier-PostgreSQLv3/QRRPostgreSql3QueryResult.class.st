Class {
	#name : #QRRPostgreSql3QueryResult,
	#superclass : #QRRRawQueryResult,
	#instVars : [
		'driver',
		'queryString',
		'columns'
	],
	#category : #'Querier-PostgreSQLv3'
}

{ #category : #'instance creation' }
QRRPostgreSql3QueryResult class >> driver: aDriver query: queryString [
	^ self new
		driver: aDriver;
		queryString: queryString
]

{ #category : #accessing }
QRRPostgreSql3QueryResult >> affectedRows [
	^ driver executeAndReturnAffectedRows: queryString
]

{ #category : #accessing }
QRRPostgreSql3QueryResult >> columns [
	^ columns
]

{ #category : #private }
QRRPostgreSql3QueryResult >> driver: anObject [
	driver := anObject
]

{ #category : #private }
QRRPostgreSql3QueryResult >> queryString: anObject [
	queryString := anObject
]

{ #category : #enumerating }
QRRPostgreSql3QueryResult >> rowsDo: aBlock [
	columns := driver execute: queryString rowsDo: aBlock
]
