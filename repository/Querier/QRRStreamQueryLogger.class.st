Class {
	#name : #QRRStreamQueryLogger,
	#superclass : #QRRQueryLogger,
	#instVars : [
		'stream',
		'prefix',
		'suffix'
	],
	#category : 'Querier-Logging'
}

{ #category : #'instance creation' }
QRRStreamQueryLogger class >> on: aStream [
	^ self new
		stream: aStream
]

{ #category : #initialization }
QRRStreamQueryLogger >> initialize [
	super initialize.
	
	prefix := ''.
	suffix := String cr
]

{ #category : #api }
QRRStreamQueryLogger >> log: queryString [
	stream
		nextPutAll: prefix value;
		nextPutAll: queryString;
		nextPutAll: suffix value
]

{ #category : #accessing }
QRRStreamQueryLogger >> prefix: aStringOrBlock [
	prefix := aStringOrBlock
]

{ #category : #accessing }
QRRStreamQueryLogger >> stream: aStream [
	stream := aStream
]

{ #category : #accessing }
QRRStreamQueryLogger >> suffix: aStringOrBlock [
	suffix := aStringOrBlock
]
