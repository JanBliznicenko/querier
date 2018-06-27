*Querier
asSqlValue
	^ String new: 19 streamContents: [ :stream |
			self printYMDOn: stream.
			stream space.
			self printHMSOn: stream ]