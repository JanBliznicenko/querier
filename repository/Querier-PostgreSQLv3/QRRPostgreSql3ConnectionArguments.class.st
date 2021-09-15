Class {
	#name : #QRRPostgreSql3ConnectionArguments,
	#superclass : #QRRRawQueryResult,
	#instVars : [
		'username',
		'password',
		'hostname',
		'port',
		'database'
	],
	#category : #'Querier-PostgreSQLv3'
}

{ #category : #'as yet unclassified' }
QRRPostgreSql3ConnectionArguments class >> hostname: hostname port: port database: database username: username password: password [

	^ self new
		  hostname: hostname;
		  port: port;
		  database: database;
		  username: username;
		  password: password;
		  yourself
]

{ #category : #accessing }
QRRPostgreSql3ConnectionArguments >> database [

	^ database
]

{ #category : #accessing }
QRRPostgreSql3ConnectionArguments >> database: anObject [

	database := anObject
]

{ #category : #accessing }
QRRPostgreSql3ConnectionArguments >> databaseOn: aStream [

	database ifNil: [ ^ self ].
	aStream
		nextPut: $/;
		nextPutAll: database
]

{ #category : #accessing }
QRRPostgreSql3ConnectionArguments >> hostname [

	^ hostname
]

{ #category : #accessing }
QRRPostgreSql3ConnectionArguments >> hostname: anObject [

	hostname := anObject
]

{ #category : #initialization }
QRRPostgreSql3ConnectionArguments >> initialize [

	super initialize.
	username := 'postgres'.
	hostname := 'localhost'.
	port := 5432
]

{ #category : #accessing }
QRRPostgreSql3ConnectionArguments >> password [

	^ password
]

{ #category : #accessing }
QRRPostgreSql3ConnectionArguments >> password: anObject [

	password := anObject
]

{ #category : #accessing }
QRRPostgreSql3ConnectionArguments >> passwordOn: aStream [

	password ifNil: [ ^ self ].
	aStream
		nextPut: $:;
		nextPutAll: password
]

{ #category : #accessing }
QRRPostgreSql3ConnectionArguments >> port [

	^ port
]

{ #category : #accessing }
QRRPostgreSql3ConnectionArguments >> port: anObject [

	port := anObject
]

{ #category : #accessing }
QRRPostgreSql3ConnectionArguments >> url [

	^ String streamContents: [ :s | 
		  s << 'psql://' << self username.
		  self passwordOn: s.
		  s nextPut: $@.
		  s << self hostname << ':' << self port asString.
		  self databaseOn: s ]
]

{ #category : #accessing }
QRRPostgreSql3ConnectionArguments >> username [

	^ username
]

{ #category : #accessing }
QRRPostgreSql3ConnectionArguments >> username: anObject [

	username := anObject
]
