Class {
	#name : #QRRAccessorObject,
	#superclass : #Object,
	#category : 'Querier-Core'
}

{ #category : #accessing }
QRRAccessorObject >> at: key [
	self subclassResponsibility
]

{ #category : #accessing }
QRRAccessorObject >> at: key put: value [
	self subclassResponsibility
]

{ #category : #'hidden methods' }
QRRAccessorObject >> changed [
	^ self at: #changed
]

{ #category : #'hidden methods' }
QRRAccessorObject >> changed: value [
	^ self at: #changed put: value
]

{ #category : #'hidden methods' }
QRRAccessorObject >> error [
	^ self at: #error
]

{ #category : #'hidden methods' }
QRRAccessorObject >> error: value [
	^ self at: #error put: value
]

{ #category : #'hidden methods' }
QRRAccessorObject >> head [
	^ self at: #head
]

{ #category : #'hidden methods' }
QRRAccessorObject >> name [
	^ self at: #name
]

{ #category : #'hidden methods' }
QRRAccessorObject >> requirement [
	^ self at: #requirement
]

{ #category : #'hidden methods' }
QRRAccessorObject >> size [
	^ self at: #size
]

{ #category : #'hidden methods' }
QRRAccessorObject >> tail [
	^ self at: #tail
]

{ #category : #'hidden methods' }
QRRAccessorObject >> update: value [
	^ self at: #update put: value
]

{ #category : #'hidden methods' }
QRRAccessorObject >> value [
	^ self at: #value
]
