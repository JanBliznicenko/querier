helpers
binaryOperationSymbol: aSymbol
	^ {
			#~= -> #!=.
			#':=' -> #=
		} asDictionary
			at: aSymbol
			ifAbsent: [ aSymbol ]