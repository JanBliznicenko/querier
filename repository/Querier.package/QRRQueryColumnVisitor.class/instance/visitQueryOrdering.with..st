visiting
visitQueryOrdering: aQueryOrdering with: aStream
	aQueryOrdering columnsAndDirectionsDo: [ :column :direction |
		self visit: column with: aStream ]