accessing
primaryKeyIn: tableString
	^ self primaryKey format:
			(self tableFormatDictionaryFor: (self basicTableNameFrom: tableString))