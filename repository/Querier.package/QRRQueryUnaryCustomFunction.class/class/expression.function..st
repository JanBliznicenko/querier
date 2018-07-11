instance creation
expression: aQueryExpression function: aString
	^ self new
		expression: aQueryExpression;
		functionName: aString