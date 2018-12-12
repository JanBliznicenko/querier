Class {
	#name : #QRRQueryPluggableColumnVisitor,
	#superclass : #QRRQueryColumnVisitor,
	#category : 'Querier-Queries-Visitors'
}

{ #category : #'instance creation' }
QRRQueryPluggableColumnVisitor class >> columnsIn: aQueryComponent do: aBlock [
	^ self new visit: aQueryComponent with: aBlock
]

{ #category : #visiting }
QRRQueryPluggableColumnVisitor >> visitQueryColumn: aQueryColumn with: aBlock [
	aBlock value: aQueryColumn
]

{ #category : #visiting }
QRRQueryPluggableColumnVisitor >> visitQueryExternalColumn: aQueryColumn with: aBlock [
	"Do nothing."
]
