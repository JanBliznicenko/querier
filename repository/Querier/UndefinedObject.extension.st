Extension { #name : #UndefinedObject }

{ #category : #'*Querier' }
UndefinedObject >> asQuerierExpression [
	^ QRRQueryConstant with: 'NULL'
]
