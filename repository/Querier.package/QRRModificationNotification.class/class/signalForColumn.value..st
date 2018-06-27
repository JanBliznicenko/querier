signaling
signalForColumn: aColumn value: value
	^ self new
		column: aColumn;
		value: value;
		signal