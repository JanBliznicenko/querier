instance creation
columnsIn: aQueryComponent do: aBlock
	^ self new visit: aQueryComponent with: aBlock