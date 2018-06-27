visiting - query parts
visitQueryJoin: aQueryJoin with: aStream
	aStream
		cr;
		nextPutAll: 'LEFT JOIN ';
		nextPutAll: (self escapeIdentifier: aQueryJoin table).
	
	(aQueryJoin alias ~= aQueryJoin table)
		ifTrue: [
			aStream
				nextPutAll: ' AS ';
				nextPutAll: (self escapeIdentifier: aQueryJoin alias) ].
	
	aStream nextPutAll: ' ON '.
	self visit: aQueryJoin condition with: aStream