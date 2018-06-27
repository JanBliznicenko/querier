lazy loading
keyNotFound: key forValues: aDictionary
	| foreignKey primaryKey targetTable targetResult allValues |
	
	self flag: #todo.
	"TODO: load all columns if not all were loaded the first time + clear/update the column cache"
	
	foreignKey := self referencedColumnFor: key.
	aDictionary at: foreignKey ifAbsent: [ ^ self connectTableForKey: key forValues: aDictionary ].
	targetTable := self referencedTableFor: key.
	
	allValues := rows collect: foreignKey asSymbol thenReject: [ :each | each isNil ].
	primaryKey := structure primaryKeyIn: targetTable.
	
	targetResult := querier table: targetTable.
	targetResult select: {primaryKey -> allValues}.
	targetResult execute.
	
	rows do: [ :each |
		each
			referencedRowAt: key
			put: (targetResult at: (each at: foreignKey) ifAbsent: [ nil ]) ]