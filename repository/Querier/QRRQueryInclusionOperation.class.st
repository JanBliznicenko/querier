Class {
	#name : #QRRQueryInclusionOperation,
	#superclass : #QRRQueryBinaryOperation,
	#traits : 'QRRTQueryBooleanOperation',
	#classTraits : 'QRRTQueryBooleanOperation classTrait',
	#category : #'Querier-Queries-Expressions'
}

{ #category : #visiting }
QRRQueryInclusionOperation >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryInclusionOperation: self with: anObject
]

{ #category : #constants }
QRRQueryInclusionOperation >> operatorSymbol [
	^ nil
]
