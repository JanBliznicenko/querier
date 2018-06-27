private - aggregations
executeAggregation: aColumn
	| aggregationQuery result |
	
	aggregationQuery := QRRSelectQuery new table: self table.
	aggregationQuery addColumn: aColumn.
	aggregationQuery copyConditionFrom: query.
	aggregationQuery copyGroupingFrom: query.
	aggregationQuery copyJoinsFrom: query.
	
	result := querier executeQuery: aggregationQuery.
	self flag: #todo. "handle exceptions"
	
	"one row with one column only"
	result rowsDo: [ :row | ^ row anyOne ]