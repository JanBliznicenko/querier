helpers
functionName: aSymbol
	^ {
			#average -> #avg
		} asDictionary
			at: aSymbol
			ifAbsent: [ aSymbol ]