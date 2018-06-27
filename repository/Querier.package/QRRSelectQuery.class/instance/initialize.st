initialization
initialize
	super initialize.
	
	columns := OrderedCollection new.
	condition := QRRQueryAndCondition new.
	grouping := QRRQueryGrouping new.
	ordering := QRRQueryOrdering new.
	limit := QRRQueryLimit new.
	joins := OrderedCollection new