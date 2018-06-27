accessing
tableName
	^ tableName ifNil: [ self tableToken ]