Class {
	#name : #QRRPostgreSql3QueryBuilderStream,
	#superclass : #Object,
	#instVars : [
		'stream',
		'singleTableQuery'
	],
	#category : #'Querier-PostgreSQLv3'
}

{ #category : #'stream proxy' }
QRRPostgreSql3QueryBuilderStream >> cr [
	^ stream cr
]

{ #category : #'stream proxy' }
QRRPostgreSql3QueryBuilderStream >> nextPut: anObject [
	^ stream nextPut: anObject
]

{ #category : #'stream proxy' }
QRRPostgreSql3QueryBuilderStream >> nextPutAll: anObject [
	^ stream nextPutAll: anObject
]

{ #category : #printing }
QRRPostgreSql3QueryBuilderStream >> print: anObject [
	"Have anObject print itself on the receiver."

	self nextPutAll: anObject asString
]

{ #category : #accessing }
QRRPostgreSql3QueryBuilderStream >> singleTableQuery [
	^ singleTableQuery ifNil: [ false ]
]

{ #category : #accessing }
QRRPostgreSql3QueryBuilderStream >> singleTableQuery: anObject [
	singleTableQuery := anObject
]

{ #category : #'stream proxy' }
QRRPostgreSql3QueryBuilderStream >> space [
	^ stream space
]

{ #category : #accessing }
QRRPostgreSql3QueryBuilderStream >> stream [
	^ stream
]

{ #category : #accessing }
QRRPostgreSql3QueryBuilderStream >> stream: anObject [
	stream := anObject
]
