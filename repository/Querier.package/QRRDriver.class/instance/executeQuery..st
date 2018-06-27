query execution
executeQuery: aQuery
	^ self executeQueryString: (self buildQueryStringFrom: aQuery)