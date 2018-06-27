api - modifications
new: aDictionary
	"Create a new result so that #delete or #update: on the current one do not affect the newly created row."
	^ (self class table: self table querier: querier structure: structure rowMapping: rowMapping)
			addNewRow: aDictionary asDictionary