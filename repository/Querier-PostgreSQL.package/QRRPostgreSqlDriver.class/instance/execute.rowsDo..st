lazy execution
execute: queryString rowsDo: aBlock
	| columns |
	
	columns := nil.
	
	self ensureConnection.
	
	connection
		execute: queryString
		withRowBlock: [ :description :data |
			| dictionary |
			
			columns ifNil: [
				columns := description columnDescriptions collect: [ :each | each fieldName asSymbol ] ].
			
			dictionary := Dictionary new.
			columns withIndexDo: [ :column :index |
				dictionary at: column put: (data at: index) ].
			
			aBlock value: dictionary ].
	
	^ columns