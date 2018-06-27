visiting - query parts
visitQueryGrouping: aQueryGrouping with: aStream
	aQueryGrouping isEmpty ifTrue: [
		^ self ].
	
	aStream nextPutAll: ' GROUP BY '.
	
	aQueryGrouping
		columnsDo: [ :column |
			self visit: column with: aStream ]
		separatedBy: [
			aStream nextPutAll: ', ' ].
	
	self visitCondition: aQueryGrouping condition
		precededBy: ' HAVING '
		with: aStream