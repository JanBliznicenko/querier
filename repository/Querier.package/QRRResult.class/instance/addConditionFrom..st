private - conditions
addConditionFrom: aCollectionOrBlock
	aCollectionOrBlock isCollection
		ifTrue: [ self addConditionsFromDictionary: aCollectionOrBlock asDictionary ]
		ifFalse: [ self addCondition: (self createConditionFromBlock: aCollectionOrBlock) ]