accessing
referencedTableFor: nameString in: tableString
	^ self tablePrefix ,
		self tableName format: (self tableFormatDictionaryFor: nameString)