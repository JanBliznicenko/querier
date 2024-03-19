Class {
	#name : #QRRQueryCondition,
	#superclass : #QRRQueryOperation,
	#traits : 'QRRTQueryBooleanOperation',
	#classTraits : 'QRRTQueryBooleanOperation classTrait',
	#instVars : [
		'conditions'
	],
	#category : #'Querier-Queries-Expressions'
}

{ #category : #'instance creation' }
QRRQueryCondition class >> with: aCondition [
	^ self new
		addCondition: aCondition;
		yourself
]

{ #category : #'instance creation' }
QRRQueryCondition class >> with: firstCondition with: secondCondition [
	^ self new
		addCondition: firstCondition;
		addCondition: secondCondition;
		yourself
]

{ #category : #visiting }
QRRQueryCondition >> accept: aVisitor with: anObject [
	^ aVisitor visitQueryCondition: self with: anObject
]

{ #category : #accessing }
QRRQueryCondition >> addCondition: aCondition [
	^ conditions add: aCondition
]

{ #category : #enumerating }
QRRQueryCondition >> conditionsDo: aBlock [
	conditions do: aBlock
]

{ #category : #enumerating }
QRRQueryCondition >> conditionsDo: aBlock separatedBy: separatorBlock [
	conditions do: aBlock separatedBy: separatorBlock
]

{ #category : #initialization }
QRRQueryCondition >> initialize [
	super initialize.
	
	conditions := OrderedCollection new
]

{ #category : #testing }
QRRQueryCondition >> isEmpty [
	^ conditions isEmpty
]
