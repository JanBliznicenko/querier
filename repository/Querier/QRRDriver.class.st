Class {
	#name : #QRRDriver,
	#superclass : #Object,
	#instVars : [
		'queryBuilder',
		'logger'
	],
	#category : 'Querier-Drivers'
}

{ #category : #'query execution' }
QRRDriver >> buildQueryStringFrom: aQuery [
	^ self queryBuilder buildStringFrom: aQuery
]

{ #category : #accessing }
QRRDriver >> defaultLogger [
	^ QRRNullQueryLogger new
]

{ #category : #accessing }
QRRDriver >> defaultQueryBuilder [
	self subclassResponsibility
]

{ #category : #private }
QRRDriver >> executeAndFetchResult: queryString [
	self subclassResponsibility
]

{ #category : #'query execution' }
QRRDriver >> executeQuery: aQuery [
	^ self executeQueryString: (self buildQueryStringFrom: aQuery)
]

{ #category : #'query execution' }
QRRDriver >> executeQueryString: queryString [
	self logger log: queryString.
	
	^ self executeAndFetchResult: queryString
]

{ #category : #accessing }
QRRDriver >> logger [
	^ logger ifNil: [ logger := self defaultLogger ]
]

{ #category : #accessing }
QRRDriver >> logger: aLogger [
	logger := aLogger
]

{ #category : #accessing }
QRRDriver >> queryBuilder [
	^ queryBuilder ifNil: [ queryBuilder := self defaultQueryBuilder ]
]
