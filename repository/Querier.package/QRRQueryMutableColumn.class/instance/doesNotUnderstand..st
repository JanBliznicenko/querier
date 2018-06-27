expression building
doesNotUnderstand: aMessage
	aMessage numArgs = 1
		ifTrue: [
			^ self at: aMessage selector allButLast put: aMessage argument ].
	
	^ super doesNotUnderstand: aMessage