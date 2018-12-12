Extension { #name : #String }

{ #category : #'*Querier' }
String >> asQuerierExpression [
	^ QRRQueryStringConstant with: self
]
