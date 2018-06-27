api
log: queryString
	stream
		nextPutAll: prefix value;
		nextPutAll: queryString;
		nextPutAll: suffix value