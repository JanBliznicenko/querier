expression building
| anObject
	self addCondition: anObject asQuerierExpression.
	^ self