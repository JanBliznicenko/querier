expression building
at: key put: value
	^ self error: 'This column is not mutable.'