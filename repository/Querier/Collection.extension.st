Extension { #name : #Collection }

{ #category : #'*Querier' }
Collection >> asQuerierExpression [
	^ QRRQueryCollectionConstant with: (self collect: #asQuerierExpression)
]
