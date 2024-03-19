Class {
	#name : #QRRQueryNotOperation,
	#superclass : #QRRQueryUnaryOperation,
	#traits : 'QRRTQueryBooleanOperation',
	#classTraits : 'QRRTQueryBooleanOperation classTrait',
	#category : #'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryNotOperation >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryNotOperation: self with: anObject
]
