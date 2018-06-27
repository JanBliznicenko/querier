helpers
keywordForOrderDirection: aSymbol
	^ aSymbol = #descending
			ifTrue: 'DESC'
			ifFalse: 'ASC'