private
errorInvalidModification: messageString
	^ QRRInvalidModification new
		table: self table;
		signal: messageString