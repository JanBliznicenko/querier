Extension { #name : #Number }

{ #category : #'*Querier' }
Number >> asQuerierExpression [
	^ QRRQueryNumberConstant with: self
]
