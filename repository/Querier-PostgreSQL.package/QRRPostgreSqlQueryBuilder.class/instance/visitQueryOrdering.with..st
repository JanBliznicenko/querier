visiting - query parts
visitQueryOrdering: aQueryOrdering with: aStream
	aQueryOrdering isEmpty ifTrue: [
		^ self ].
	
	aStream
		cr;
		nextPutAll: 'ORDER BY '.
	
	aQueryOrdering
		columnsAndDirectionsDo: [ :column :direction |
			self visit: column with: aStream.
			aStream
				space;
				nextPutAll: (self keywordForOrderDirection: direction) ]
		separatedBy: [
			aStream nextPutAll: ', ' ]