Class {
	#name : #QRRQueryUnaryCustomFunction,
	#superclass : #QRRQueryUnaryFunction,
	#instVars : [
		'functionName'
	],
	#category : 'Querier-Queries-Expressions'
}

{ #category : #'instance creation' }
QRRQueryUnaryCustomFunction class >> expression: aQueryExpression function: aString [
	^ self new
		expression: aQueryExpression;
		functionName: aString
]

{ #category : #accessing }
QRRQueryUnaryCustomFunction >> functionName [
	^ functionName
]

{ #category : #accessing }
QRRQueryUnaryCustomFunction >> functionName: aString [
	functionName := aString
]
