helpers
escapeValue: aString
	^ self enclose: aString in: self valueEnclosingCharacter.