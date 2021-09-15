Class {
	#name : #QRRPostgreSql3Driver,
	#superclass : #QRRDriver,
	#instVars : [
		'client',
		'mutex'
	],
	#category : #'Querier-PostgreSQLv3'
}

{ #category : #'instance creation' }
QRRPostgreSql3Driver class >> client: aP3Client [

	^ self new
		  client: aP3Client;
		  yourself
]

{ #category : #private }
QRRPostgreSql3Driver >> client: aP3Client [
	client := aP3Client
]

{ #category : #accessing }
QRRPostgreSql3Driver >> defaultQueryBuilder [
	^ QRRPostgreSql3QueryBuilder new
]

{ #category : #private }
QRRPostgreSql3Driver >> ensureConnection [

	[ client ensureConnected ]
		on: P3Error
		do: [ :error | 
			QRRPostgreSql3Error signal:
				'P3Error: ' , error messageText asString ]
]

{ #category : #'lazy execution' }
QRRPostgreSql3Driver >> execute: queryString rowsDo: aBlock [

	| result columns p3Error |
	p3Error := nil.

	result := mutex critical: [ 
		          self ensureConnection.
		          [ client query: queryString ]
			          on: P3Error
			          do: [ :error | p3Error := error ] ].

	p3Error ifNotNil: [ 
		QRRPostgreSql3Error signal:
			'P3Error: ' , p3Error messageText asString ].

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

{ #category : #private }
QRRPostgreSql3Driver >> executeAndFetchResult: queryString [
	^ QRRPostgreSql3QueryResult driver: self query: queryString
]

{ #category : #'lazy execution' }
QRRPostgreSql3Driver >> executeAndReturnAffectedRows: commandString [

	| result p3Error |
	p3Error := nil.

	result := mutex critical: [ 
		          self ensureConnection.
		          [ client execute: commandString ]
			          on: P3Error
			          do: [ :error | p3Error := error ] ].

	p3Error ifNotNil: [ 
		QRRPostgreSql3Error signal:
			'P3Error: ' , p3Error messageText asString ].

	^ (result splitOn: Character space) last asInteger
]

{ #category : #initialization }
QRRPostgreSql3Driver >> initialize [

	super initialize.
	mutex := Mutex new
]
