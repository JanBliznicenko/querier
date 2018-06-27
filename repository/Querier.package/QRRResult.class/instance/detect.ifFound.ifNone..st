api - enumerating
detect: aBlock ifFound: foundBlock ifNone: notFoundBlock
	| row |
	
	self select: aBlock.
	self limit: 1.
	
	row := self fetchOne.
	
	^ row ifNotNil: foundBlock ifNil: notFoundBlock