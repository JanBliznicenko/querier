api
buildStringFrom: aQuery
	^ String streamContents: [ :stream |
			| streamWrapper |
			
			streamWrapper := QRRPostgreSqlQueryBuilderStream new stream: stream.
			
			self visit: aQuery with: streamWrapper ]