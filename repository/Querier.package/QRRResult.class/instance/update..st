api - modifications
update: aBlock
	| updateQuery condition queryResult |
	
	(executed and: [ primaryKeyColumn isNil ])
		ifTrue: [
			self errorInvalidModification: 'Cannot update selected rows because table ' , self table , ' is missing a primary key.'.
			^ 0 ].
	
	"No rows => nothing to do."
	(executed and: [ self size = 0 ])
		ifTrue: [ ^ 0 ].
	
	condition :=
		executed
			ifTrue: [ self createPrimaryKeyInclusionCondition ]
			ifFalse: [ query condition ].
	
	updateQuery := QRRUpdateQuery new table: self table.
	updateQuery addCondition: condition.
	
	[ aBlock value: self createMutableTableColumn ]
		on: QRRModificationNotification do: [ :modification |
			updateQuery
				addColumn: modification column
				value: modification value.
			modification resume ].
	
	queryResult := querier executeQuery: updateQuery.
	self flag: #todo. "check for exceptions"
	
	^ queryResult affectedRows