private
primaryKeyForRow: aDictionary
	primaryKeyColumn ifNil: [ ^ nil ].
	
	^ aDictionary at: primaryKeyColumn ifAbsent: [ nil ]