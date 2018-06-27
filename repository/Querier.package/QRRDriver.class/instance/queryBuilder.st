accessing
queryBuilder
	^ queryBuilder ifNil: [ queryBuilder := self defaultQueryBuilder ]