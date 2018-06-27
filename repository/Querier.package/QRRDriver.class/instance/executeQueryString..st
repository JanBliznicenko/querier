query execution
executeQueryString: queryString
	self logger log: queryString.
	
	^ self executeAndFetchResult: queryString