instance creation
table: nameString querier: aQuerier structure: aStructure rowMapping: rowMapping
	^ self new
		structure: aStructure;
		rowMapping: rowMapping;
		querier: aQuerier;
		table: nameString