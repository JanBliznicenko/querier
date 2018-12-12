Class {
	#name : #QRRDatabaseStructure,
	#superclass : #Object,
	#category : 'Querier-Structure'
}

{ #category : #accessing }
QRRDatabaseStructure >> connectedColumnFor: nameString in: tableString [
	self subclassResponsibility
]

{ #category : #accessing }
QRRDatabaseStructure >> connectedTableFor: nameString in: tableString [
	self subclassResponsibility
]

{ #category : #accessing }
QRRDatabaseStructure >> primaryKeyIn: tableString [
	self subclassResponsibility
]

{ #category : #accessing }
QRRDatabaseStructure >> referencedColumnFor: nameString in: tableString [
	self subclassResponsibility
]

{ #category : #accessing }
QRRDatabaseStructure >> referencedTableFor: nameString in: tableString [
	self subclassResponsibility
]

{ #category : #accessing }
QRRDatabaseStructure >> referencingColumnFor: nameString in: tableString [
	self subclassResponsibility
]

{ #category : #accessing }
QRRDatabaseStructure >> referencingTableFor: nameString in: tableString [
	self subclassResponsibility
]
