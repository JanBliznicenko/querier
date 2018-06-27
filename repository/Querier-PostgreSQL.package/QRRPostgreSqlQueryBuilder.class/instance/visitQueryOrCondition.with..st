visiting - conditions
visitQueryOrCondition: aQueryCondition with: aStream
	self visitQueryCondition: aQueryCondition
		separatedBy: ' OR '
		with: aStream