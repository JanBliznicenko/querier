accessing
basicTableNameFrom: tableString
	| prefixAndSuffix |
	
	self tableName = self tableToken
		ifTrue: [ ^ tableString ].
	
	"Strip prefix and suffix"
	prefixAndSuffix := self tableToken split: tableString.
	
	^ (tableString
			allButFirst: prefixAndSuffix first length)
			allButLast: prefixAndSuffix second length