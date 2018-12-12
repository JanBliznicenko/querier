"
I am a column that is external to the query, i.e. comes from a different query. These may appear in nested queries.
"
Class {
	#name : #QRRQueryExternalColumn,
	#superclass : #QRRQueryColumn,
	#category : 'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryExternalColumn >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryExternalColumn: self with: anObject
]
