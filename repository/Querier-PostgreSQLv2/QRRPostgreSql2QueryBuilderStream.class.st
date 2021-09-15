Class {
	#name : #QRRPostgreSql2QueryBuilderStream,
	#superclass : #Object,
	#instVars : [
		'stream',
		'singleTableQuery'
	],
	#category : #'Querier-PostgreSQLv2'
}

{ #category : #'stream proxy' }
QRRPostgreSql2QueryBuilderStream >> cr [
	^ stream cr
]

{ #category : #'stream proxy' }
QRRPostgreSql2QueryBuilderStream >> nextPut: anObject [
	^ stream nextPut: anObject
]

{ #category : #'stream proxy' }
QRRPostgreSql2QueryBuilderStream >> nextPutAll: anObject [
	^ stream nextPutAll: anObject
]

{ #category : #printing }
QRRPostgreSql2QueryBuilderStream >> print: anObject [
	"Have anObject print itself on the receiver."

	self nextPutAll: anObject asString
]

{ #category : #accessing }
QRRPostgreSql2QueryBuilderStream >> singleTableQuery [
	^ singleTableQuery ifNil: [ false ]
]

{ #category : #accessing }
QRRPostgreSql2QueryBuilderStream >> singleTableQuery: anObject [
	singleTableQuery := anObject
]

{ #category : #'stream proxy' }
QRRPostgreSql2QueryBuilderStream >> space [
	^ stream space
]

{ #category : #accessing }
QRRPostgreSql2QueryBuilderStream >> stream [
	^ stream
]

{ #category : #accessing }
QRRPostgreSql2QueryBuilderStream >> stream: anObject [
	stream := anObject
]
