private - columns
createTableColumn: aString
	^ QRRQueryColumn identifiers: (Array with: self table with: aString)