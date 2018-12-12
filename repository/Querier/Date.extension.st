Extension { #name : #Date }

{ #category : #'*Querier' }
Date >> asQuerierExpression [
	^ QRRQueryStringConstant with: self asSqlValue
]

{ #category : #'*Querier' }
Date >> asSqlValue [
	^ self yyyymmdd
]
