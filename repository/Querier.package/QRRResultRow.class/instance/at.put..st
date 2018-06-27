api
at: key put: value
	self flag: #todo.
	
	key isArray ifTrue: [
		^ key size = 1
				ifTrue: [ self at: key first put: value ]
				ifFalse: [ (self at: key first) at: key allButFirst put: value ] ].
	
	(referencedRows notNil and: [ referencedRows includesKey: key ])
		ifTrue: [
			value = (referencedRows at: key) ifTrue: [
				^ value ].
			
			referencedRows at: key put: value.
			values at: (result referencedColumnFor: key) put: value primaryKeyValue.
			modifiedColumns at: (result referencedColumnFor: key) put: true.
			^ value ].
	
	value = (self at: key) ifTrue: [
		^ value ].
	
	modifiedColumns at: key put: true.
	^ values at: key put: value