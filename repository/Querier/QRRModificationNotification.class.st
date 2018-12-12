Class {
	#name : #QRRModificationNotification,
	#superclass : #Notification,
	#instVars : [
		'column',
		'value'
	],
	#category : 'Querier-Queries-Expressions'
}

{ #category : #signaling }
QRRModificationNotification class >> signalForColumn: aColumn value: value [
	^ self new
		column: aColumn;
		value: value;
		signal
]

{ #category : #accessing }
QRRModificationNotification >> column [
	^ column
]

{ #category : #accessing }
QRRModificationNotification >> column: anObject [
	column := anObject
]

{ #category : #accessing }
QRRModificationNotification >> defaultAction [
	self resume: self signaler
]

{ #category : #accessing }
QRRModificationNotification >> value [
	^ value
]

{ #category : #accessing }
QRRModificationNotification >> value: anObject [
	value := anObject
]
