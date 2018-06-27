api
referencedRowAt: key ifPresent: aBlock
	referencedRows ifNil: [ ^ nil ].
	
	^ referencedRows at: key ifPresent: aBlock