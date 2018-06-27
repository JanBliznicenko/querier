helpers
escapeIdentifier: aString
	^ self enclose: aString in: self identifierEnclosingCharacter.