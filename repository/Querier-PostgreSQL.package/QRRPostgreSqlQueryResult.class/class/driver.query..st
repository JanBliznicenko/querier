instance creation
driver: aDriver query: queryString
	^ self new
		driver: aDriver;
		queryString: queryString