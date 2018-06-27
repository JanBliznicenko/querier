api
asDictionary
	referencedRows
		ifNotNil: [ ^ values , referencedRows ]
		ifNil: [ ^ values ]