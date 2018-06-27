private - conditions
addCondition: aCondition

	
	self createJoinsIn: aCondition.
	
	query addCondition: aCondition