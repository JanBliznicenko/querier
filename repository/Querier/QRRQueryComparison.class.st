Class {
	#name : #QRRQueryComparison,
	#superclass : #QRRQueryBinaryOperation,
	#traits : 'QRRTQueryBooleanOperation',
	#classTraits : 'QRRTQueryBooleanOperation classTrait',
	#category : #'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryComparison >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryComparison: self with: anObject
]
