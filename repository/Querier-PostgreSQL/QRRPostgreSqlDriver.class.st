Class {
	#name : #QRRPostgreSqlDriver,
	#superclass : #QRRDriver,
	#instVars : [
		'connection'
	],
	#category : 'Querier-PostgreSQL'
}

{ #category : #'instance creation' }
QRRPostgreSqlDriver class >> connection: aPgConnection [
	^ self new
		connection: aPgConnection
]

{ #category : #private }
QRRPostgreSqlDriver >> connection: aPgConnection [
	connection := aPgConnection
]

{ #category : #accessing }
QRRPostgreSqlDriver >> defaultQueryBuilder [
	^ QRRPostgreSqlQueryBuilder new
]

{ #category : #private }
QRRPostgreSqlDriver >> ensureConnection [
	connection isConnected ifFalse: [
		[ connection terminate ]
			on: Error do: [ :error | error return ].
		connection initialize.
		[ connection startup ]
			on: ConnectionTimedOut do: [ :error |
				QRRPostgreSqlError signal: 'Connection timed out.' ] ]
]

{ #category : #'lazy execution' }
QRRPostgreSqlDriver >> execute: queryString rowsDo: aBlock [
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
QRRPostgreSqlDriver >> executeAndFetchResult: queryString [
	^ QRRPostgreSqlQueryResult driver: self query: queryString
]

{ #category : #'lazy execution' }
QRRPostgreSqlDriver >> executeAndReturnAffectedRows: queryString [
	| result |
	
	self ensureConnection.
	
	result := connection execute: queryString.
	
	result errorResponse ifNotNil: [ :error |
		QRRPostgreSqlError signal: error value ].
	
	result lastResultSet
		ifNil: [ QRRPostgreSqlError signal: 'No result set.' ]
		ifNotNil: [ ^ result lastResultSet completedResponse value asInteger ]
]
