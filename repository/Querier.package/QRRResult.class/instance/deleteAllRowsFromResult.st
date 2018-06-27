private - modifications
deleteAllRowsFromResult
	| condition |
	
	primaryKeyColumn ifNil: [
		self errorInvalidModification: 'Cannot delete selected rows because table ' , self table , ' is missing a primary key.'.
		^ 0 ].
	
	"No rows => nothing to do."
	self size = 0
		ifTrue: [ ^ 0 ].
	
	condition := self createPrimaryKeyInclusionCondition.
	
	^ self deleteWithCondition: condition