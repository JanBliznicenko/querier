converting
convertToConstant: anObject andSend: selector
	^ anObject asQuerierExpression perform: selector with: self