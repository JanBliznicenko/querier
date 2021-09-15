Class {
	#name : #QRRPostgreSql2Driver,
	#superclass : #QRRDriver,
	#instVars : [
		'connection'
	],
	#category : #'Querier-PostgreSQLv2'
}

{ #category : #'instance creation' }
QRRPostgreSql2Driver class >> connection: aPgConnection [
	^ self new
		connection: aPgConnection
]

{ #category : #private }
QRRPostgreSql2Driver >> connection: aPgConnection [
	connection := aPgConnection
]

{ #category : #accessing }
QRRPostgreSql2Driver >> defaultQueryBuilder [
	^ QRRPostgreSql2QueryBuilder new
]

{ #category : #private }
QRRPostgreSql2Driver >> ensureConnection [
	connection isConnected ifFalse: [
		[ connection terminate ]
			on: Error do: [ :error | error return ].
		connection initialize.
		[ connection startup ]
			on: ConnectionTimedOut do: [ :error |
				QRRPostgreSql2Error signal: 'Connection timed out.' ] ]
]

{ #category : #'lazy execution' }
QRRPostgreSql2Driver >> execute: queryString rowsDo: aBlock [
	| columns |
	
	columns := nil.
	
	self ensureConnection.
	
	connection
		execute: queryString
		withRowBlock: [ :description :data |
			| dictionary |
			
			columns ifNil: [
				columns := description columnDescriptions collect: [ :each | each fieldName asSymbol ] ].
			
			dictionary := Dictionary new.
			columns withIndexDo: [ :column :index |
				dictionary at: column put: (data at: index) ].
			
			aBlock value: dictionary ].
	
	^ columns
]

{ #category : #private }
QRRPostgreSql2Driver >> executeAndFetchResult: queryString [
	^ QRRPostgreSql2QueryResult driver: self query: queryString
]

{ #category : #'lazy execution' }
QRRPostgreSql2Driver >> executeAndReturnAffectedRows: queryString [
	| result |
	
	self ensureConnection.
	
	result := connection execute: queryString.
	
	result errorResponse ifNotNil: [ :error |
		QRRPostgreSql2Error signal: error value ].
	
	result lastResultSet
		ifNil: [ QRRPostgreSql2Error signal: 'No result set.' ]
		ifNotNil: [ ^ result lastResultSet completedResponse value asInteger ]
]
