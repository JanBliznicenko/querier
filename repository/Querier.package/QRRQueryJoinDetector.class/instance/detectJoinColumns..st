detecting
detectJoinColumns: aQueryComponent
	^ Array streamContents: [ :stream |
			self visit: aQueryComponent with: stream ]