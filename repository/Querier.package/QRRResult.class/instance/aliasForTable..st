private
aliasForTable: aString
	| alias index |
	
	alias := aString.
	index := 1.
	
	[ usedTables includes: alias ]
		whileTrue: [
			alias := aString , '__' , (index := index + 1) asString ].
	
	^ alias