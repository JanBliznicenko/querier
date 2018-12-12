Class {
	#name : #QRRQueryEmptyVisitor,
	#superclass : #QRRQueryVisitor,
	#category : 'Querier-Queries-Visitors'
}

{ #category : #visiting }
QRRQueryEmptyVisitor >> visitQueryComponent: aQueryComponent with: anObject [
	"Do nothing by default."
]
