Extension { #name : #Object }

{ #category : #'*Querier' }
Object >> asQuerierExpression [
	^ QRRQueryConstant with: self
]
