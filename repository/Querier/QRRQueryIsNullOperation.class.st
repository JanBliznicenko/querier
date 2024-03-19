Class {
	#name : #QRRQueryIsNullOperation,
	#superclass : #QRRQueryUnaryOperation,
	#traits : 'QRRTQueryBooleanOperation',
	#classTraits : 'QRRTQueryBooleanOperation classTrait',
	#category : #'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryIsNullOperation >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryIsNullOperation: self with: anObject
]
