enumerating
columnsAndValuesDo: twoParameterBlock separatedBy: separatorBlock
	columnsAndValues
		do: [ :each |
			twoParameterBlock value: each key value: each value ]
		separatedBy: separatorBlock