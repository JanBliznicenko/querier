api
referencedRowAt: key ifAbsent: aBlock
	referencedRows ifNil: [ ^ aBlock value ].
	
	^ referencedRows at: key ifAbsent: aBlock