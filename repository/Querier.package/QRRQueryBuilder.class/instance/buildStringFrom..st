api
buildStringFrom: aQuery
	^ String streamContents: [ :stream |
			self visit: aQuery with: stream ]