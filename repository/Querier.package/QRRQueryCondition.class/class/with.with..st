instance creation
with: firstCondition with: secondCondition
	^ self new
		addCondition: firstCondition;
		addCondition: secondCondition;
		yourself