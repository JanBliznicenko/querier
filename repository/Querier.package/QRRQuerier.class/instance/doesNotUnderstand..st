api
doesNotUnderstand: aMessage
	aMessage numArgs = 0
		ifTrue: [
			^ self table: aMessage selector ].
	
	aMessage numArgs = 1
		ifTrue: [
			^ (self table: aMessage selector allButLast asSymbol)
					select: aMessage argument ].
	
	^ super doesNotUnderstand: aMessage