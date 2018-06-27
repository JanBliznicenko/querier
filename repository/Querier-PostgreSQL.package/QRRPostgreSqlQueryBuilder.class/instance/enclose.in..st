helpers
enclose: aString in: enclosingChar
	^ String streamContents: [ :stream |
			stream nextPut: enclosingChar.
			aString do: [ :char |
				stream nextPut: char.
				char = enclosingChar ifTrue: [
					stream nextPut: enclosingChar ] ].
			stream nextPut: enclosingChar ]