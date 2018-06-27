initialization
initialize
	super initialize.
	
	query := QRRSelectQuery new.
	usedTables := Dictionary new.
	executed := false.
	rows := OrderedDictionary new