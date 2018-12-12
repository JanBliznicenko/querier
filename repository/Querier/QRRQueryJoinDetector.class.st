Class {
	#name : #QRRQueryJoinDetector,
	#superclass : #QRRQueryColumnVisitor,
	#category : 'Querier-Queries-Visitors'
}

{ #category : #shortcuts }
QRRQueryJoinDetector class >> detectJoinColumnsIn: aQueryComponent [
	^ self new
		detectJoinColumns: aQueryComponent
]

{ #category : #detecting }
QRRQueryJoinDetector >> detectJoinColumns: aQueryComponent [
	^ Array streamContents: [ :stream |
			self visit: aQueryComponent with: stream ]
]

{ #category : #visiting }
QRRQueryJoinDetector >> visitQueryColumn: aQueryColumn with: aStream [
	aQueryColumn ifMoreThan: 2 identifiersDo: [
		aStream nextPut: aQueryColumn ]
]
