accessing
foreignKey
	^ foreignKey ifNil: [ self targetToken , '_id' ]