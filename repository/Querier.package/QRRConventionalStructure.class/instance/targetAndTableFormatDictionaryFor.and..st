private
targetAndTableFormatDictionaryFor: targetString and: tableString
	^ Dictionary
			with: self targetTokenName -> targetString
			with: self tableTokenName -> tableString