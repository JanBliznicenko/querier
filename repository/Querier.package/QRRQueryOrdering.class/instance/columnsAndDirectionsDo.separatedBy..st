enumerating
columnsAndDirectionsDo: twoArgumentBlock separatedBy: separatorBlock
	columnsAndDirections
		do: [ :each |
			twoArgumentBlock value: each key value: each value ]
		separatedBy: separatorBlock