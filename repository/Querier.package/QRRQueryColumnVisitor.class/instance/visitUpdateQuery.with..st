visiting
visitUpdateQuery: aQuery with: aStream
	aQuery columnsAndValuesDo: [ :column :value |
		self visit: column with: aStream ].
	
	aQuery joinsDo: [ :join |
		self visit: join with: aStream ].
	
	self visit: aQuery condition with: aStream