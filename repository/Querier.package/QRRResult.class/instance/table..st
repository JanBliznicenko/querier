private - accessing
table: aString
	query table: aString.
	primaryKeyColumn := structure primaryKeyIn: aString.
	
	usedTables at: (Array with: aString) put: (QRRUsedTable table: aString)