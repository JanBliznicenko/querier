api
doesNotUnderstand: aMessage
	aMessage numArgs = 0
		ifTrue: [
			^ self at: aMessage selector ].
	
	aMessage numArgs = 1
		ifTrue: [
			^ self
					at: aMessage selector allButLast
					put: aMessage argument ].
	
	^ super doesNotUnderstand: aMessage