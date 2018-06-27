visiting - conditions
visitQueryAndCondition: aQueryCondition with: aStream
	self visitQueryCondition: aQueryCondition
		separatedBy: ' AND '
		with: aStream