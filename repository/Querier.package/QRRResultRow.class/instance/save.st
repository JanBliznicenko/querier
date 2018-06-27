api
save
	exists
		ifTrue: [ ^ result saveRow: self withColumns: modifiedColumns keys ]
		ifFalse: [ ^ result insertRow: self ]