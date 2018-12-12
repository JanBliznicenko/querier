Class {
	#name : #QRRQueryBuilder,
	#superclass : #QRRQueryVisitor,
	#category : 'Querier-Queries-Visitors'
}

{ #category : #api }
QRRQueryBuilder >> buildStringFrom: aQuery [
	^ String streamContents: [ :stream |
			self visit: aQuery with: stream ]
]
