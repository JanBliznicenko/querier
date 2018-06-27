private - conditions
addConditionsFromDictionary: aDictionary
	aDictionary keysAndValuesDo: [ :key :value |
		| conditionClass |
		conditionClass :=
			(value isCollection and: [ value isString not ])
				ifTrue: [ QRRQueryInclusionOperation ]
				ifFalse: [ QRRQueryEqualComparison ].
		
		self addCondition:
			(conditionClass left: (self createTableColumn: key) right: value asQuerierExpression) ]