Class {
	#name : #QRRConventionalStructure,
	#superclass : #QRRDatabaseStructure,
	#instVars : [
		'primaryKey',
		'foreignKey',
		'tableName',
		'tablePrefix'
	],
	#category : 'Querier-Structure'
}

{ #category : #accessing }
QRRConventionalStructure >> basicTableNameFrom: tableString [
	| prefixAndSuffix |
	
	self tableName = self tableToken
		ifTrue: [ ^ tableString ].
	
	"Strip prefix and suffix"
	prefixAndSuffix := self tableToken split: tableString.
	
	^ (tableString
			allButFirst: prefixAndSuffix first length)
			allButLast: prefixAndSuffix second length
]

{ #category : #accessing }
QRRConventionalStructure >> connectedColumnFor: nameString in: tableString [
	^ nil
]

{ #category : #accessing }
QRRConventionalStructure >> connectedTableFor: nameString in: tableString [
	^ nil
]

{ #category : #accessing }
QRRConventionalStructure >> foreignKey [
	^ foreignKey ifNil: [ self targetToken , '_id' ]
]

{ #category : #accessing }
QRRConventionalStructure >> foreignKey: aString [
	foreignKey := aString
]

{ #category : #accessing }
QRRConventionalStructure >> primaryKey [
	^ primaryKey ifNil: [ 'id' ]
]

{ #category : #accessing }
QRRConventionalStructure >> primaryKey: aString [
	primaryKey := aString
]

{ #category : #accessing }
QRRConventionalStructure >> primaryKeyIn: tableString [
	^ self primaryKey format:
			(self tableFormatDictionaryFor: (self basicTableNameFrom: tableString))
]

{ #category : #accessing }
QRRConventionalStructure >> referencedColumnFor: nameString in: tableString [
	^ self foreignKey format: (self targetAndTableFormatDictionaryFor: nameString and: tableString)
]

{ #category : #accessing }
QRRConventionalStructure >> referencedTableFor: nameString in: tableString [
	^ self tablePrefix ,
		self tableName format: (self tableFormatDictionaryFor: nameString)
]

{ #category : #accessing }
QRRConventionalStructure >> referencingTableFor: nameString in: tableString [
	^ self tablePrefix , nameString
]

{ #category : #private }
QRRConventionalStructure >> tableFormatDictionaryFor: tableString [
	^ Dictionary
			with: self tableTokenName -> tableString
]

{ #category : #accessing }
QRRConventionalStructure >> tableName [
	^ tableName ifNil: [ self tableToken ]
]

{ #category : #accessing }
QRRConventionalStructure >> tableName: aString [
	tableName := aString
]

{ #category : #accessing }
QRRConventionalStructure >> tablePrefix [
	^ tablePrefix ifNil: [ '' ]
]

{ #category : #accessing }
QRRConventionalStructure >> tablePrefix: aString [
	tablePrefix := aString
]

{ #category : #constants }
QRRConventionalStructure >> tableToken [
	^ '{' , self tableTokenName , '}'
]

{ #category : #constants }
QRRConventionalStructure >> tableTokenName [
	^ #table
]

{ #category : #private }
QRRConventionalStructure >> targetAndTableFormatDictionaryFor: targetString and: tableString [
	^ Dictionary
			with: self targetTokenName -> targetString
			with: self tableTokenName -> tableString
]

{ #category : #constants }
QRRConventionalStructure >> targetToken [
	^ '{' , self targetTokenName , '}'
]

{ #category : #constants }
QRRConventionalStructure >> targetTokenName [
	^ #target
]
