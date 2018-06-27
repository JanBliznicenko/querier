visiting - queries
visitQueryNestedQuery: aNestedQuery with: aStream
	self
		parenthesized: [
			self visit: aNestedQuery value with: aStream ]
		on: aStream