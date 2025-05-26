Class {
	#name : 'QRRPostgreSqlQueryBuilderStream',
	#superclass : 'Object',
	#instVars : [
		'stream',
		'singleTableQuery'
	],
	#category : 'Querier-PostgreSQL',
	#package : 'Querier-PostgreSQL'
}

{ #category : 'stream proxy' }
QRRPostgreSqlQueryBuilderStream >> cr [
	^ stream cr
]

{ #category : 'stream proxy' }
QRRPostgreSqlQueryBuilderStream >> nextPut: anObject [
	^ stream nextPut: anObject
]

{ #category : 'stream proxy' }
QRRPostgreSqlQueryBuilderStream >> nextPutAll: anObject [
	^ stream nextPutAll: anObject
]

{ #category : 'printing' }
QRRPostgreSqlQueryBuilderStream >> print: anObject [
	"Have anObject print itself on the receiver."

	self nextPutAll: anObject asString
]

{ #category : 'accessing' }
QRRPostgreSqlQueryBuilderStream >> singleTableQuery [
	^ singleTableQuery ifNil: [ false ]
]

{ #category : 'accessing' }
QRRPostgreSqlQueryBuilderStream >> singleTableQuery: anObject [
	singleTableQuery := anObject
]

{ #category : 'stream proxy' }
QRRPostgreSqlQueryBuilderStream >> space [
	^ stream space
]

{ #category : 'accessing' }
QRRPostgreSqlQueryBuilderStream >> stream [
	^ stream
]

{ #category : 'accessing' }
QRRPostgreSqlQueryBuilderStream >> stream: anObject [
	stream := anObject
]
