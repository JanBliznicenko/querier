visiting
visitQueryCondition: aQueryCondition with: aStream
	aQueryCondition conditionsDo: [ :each |
		self visit: each with: aStream ]