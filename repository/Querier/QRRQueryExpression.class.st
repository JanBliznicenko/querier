Class {
	#name : #QRRQueryExpression,
	#superclass : #Object,
	#traits : 'QRRTBasicQueryExpression',
	#classTraits : 'QRRTBasicQueryExpression classTrait',
	#category : 'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryExpression >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryExpression: self with: anObject
]
