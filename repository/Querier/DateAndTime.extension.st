Extension { #name : #DateAndTime }

{ #category : #'*Querier' }
DateAndTime >> asQuerierExpression [
	^ QRRQueryStringConstant with: self asSqlValue
]

{ #category : #'*Querier' }
DateAndTime >> asSqlValue [
	^ String new: 19 streamContents: [ :stream |
			self printYMDOn: stream.
			stream space.
			self printHMSOn: stream ]
]
