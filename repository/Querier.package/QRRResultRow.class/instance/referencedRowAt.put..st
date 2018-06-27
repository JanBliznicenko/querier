api
referencedRowAt: key put: aRow
	referencedRows ifNil: [ referencedRows := Dictionary new ].
	
	^ referencedRows at: key put: aRow