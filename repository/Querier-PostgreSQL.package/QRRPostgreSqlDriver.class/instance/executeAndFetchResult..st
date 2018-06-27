private
executeAndFetchResult: queryString
	^ QRRPostgreSqlQueryResult driver: self query: queryString