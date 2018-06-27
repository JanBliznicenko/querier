visiting - expressions
visitQueryIdentifier: aQueryIdentifier with: aStream
	aStream nextPutAll: (self escapeIdentifier: aQueryIdentifier value)