accessing
referencedColumnFor: nameString in: tableString
	^ self foreignKey format: (self targetAndTableFormatDictionaryFor: nameString and: tableString)