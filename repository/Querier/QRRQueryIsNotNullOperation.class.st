Class {
	#name : #QRRQueryIsNotNullOperation,
	#superclass : #QRRQueryUnaryOperation,
	#traits : 'QRRTQueryBooleanOperation',
	#classTraits : 'QRRTQueryBooleanOperation classTrait',
	#category : #'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryIsNotNullOperation >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryIsNotNullOperation: self with: anObject
]
