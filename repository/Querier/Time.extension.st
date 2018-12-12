Extension { #name : #Time }

{ #category : #'*Querier' }
Time >> asQuerierExpression [
	^ QRRQueryStringConstant with: self asSqlValue
]

{ #category : #'*Querier' }
Time >> asSqlValue [
	^ self print24
]
