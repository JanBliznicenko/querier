api - enumerating
detect: aBlock ifNone: notFoundBlock
	^ self detect: aBlock ifFound: [ :row | row ] ifNone: notFoundBlock