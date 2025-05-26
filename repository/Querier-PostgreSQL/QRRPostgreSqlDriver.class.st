Class {
	#name : 'QRRPostgreSqlDriver',
	#superclass : 'QRRDriver',
	#instVars : [
		'client',
		'mutex'
	],
	#category : 'Querier-PostgreSQL',
	#package : 'Querier-PostgreSQL'
}

{ #category : 'instance creation' }
QRRPostgreSqlDriver class >> client: aP3Client [

	^ self new client: aP3Client
]

{ #category : 'private' }
QRRPostgreSqlDriver >> client: aP3Client [

	client := aP3Client
]

{ #category : 'accessing' }
QRRPostgreSqlDriver >> defaultQueryBuilder [
	^ QRRPostgreSqlQueryBuilder new
]

{ #category : 'private' }
QRRPostgreSqlDriver >> ensureConnection [

	client isConnected ifTrue: [ ^ self ].
	[ client close ]
		on: Error
		do: [ :error | error return ].
	[ client open ]
		on: ConnectionTimedOut
		do: [ :error | QRRPostgreSqlError signal: 'Connection timed out.' ]
]

{ #category : 'lazy execution' }
QRRPostgreSqlDriver >> execute: queryString rowsDo: aBlock [

	| p3Error result columns |
	p3Error := nil.

	result := mutex critical: [ 
		          self ensureConnection.
		          [ client query: queryString ]
			          on: P3Error
			          do: [ :error | p3Error := error ] ].

	p3Error ifNotNil: [ 
		QRRPostgreSqlError signal:
			'P3Error: ' , p3Error messageText asString ].

	result descriptions ifNil: [ 
		QRRPostgreSqlError signal: (String streamContents: [ :s | 
				 s nextPutAll: 'P3Result without descriptions: '.
				 STON put: result onStream: s ]) ].

	columns := result descriptions collect: [ :each | 
		           each fieldName asSymbol ].
	result data do: [ :data | 
		| dictionary |
		dictionary := Dictionary new.
		columns withIndexDo: [ :column :index | 
			dictionary at: column put: (data at: index) ].
		aBlock value: dictionary ].

	^ columns
]

{ #category : 'private' }
QRRPostgreSqlDriver >> executeAndFetchResult: queryString [
	^ QRRPostgreSqlQueryResult driver: self query: queryString
]

{ #category : 'lazy execution' }
QRRPostgreSqlDriver >> executeAndReturnAffectedRows: queryString [

	| result p3Error |
	p3Error := nil.

	result := mutex critical: [ 
		          self ensureConnection.
		          [ client execute: queryString ]
			          on: P3Error
			          do: [ :error | p3Error := error ] ].

	p3Error ifNotNil: [ 
		QRRPostgreSqlError signal:
			'P3Error: ' , p3Error messageText asString ].

	^ (result splitOn: Character space) last asInteger
]

{ #category : 'initialization' }
QRRPostgreSqlDriver >> initialize [

	super initialize.
	mutex := Mutex new
]
