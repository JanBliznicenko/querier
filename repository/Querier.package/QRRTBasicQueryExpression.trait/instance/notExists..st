expression building
notExists: anObject
	^ QRRQueryNonExistenceOperation left: self right: anObject asQuerierExpression