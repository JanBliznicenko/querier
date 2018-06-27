private - conditions
createPrimaryKeyInclusionCondition
	^ QRRQueryInclusionOperation
			left: (self createTableColumn: primaryKeyColumn)
			right: self keys asQuerierExpression.