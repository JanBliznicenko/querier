private
ensureConnection
	connection isConnected ifFalse: [
		[ connection terminate ]
			on: Error do: [ :error | error return ].
		connection initialize.
		[ connection startup ]
			on: ConnectionTimedOut do: [ :error |
				QRRPostgreSqlError signal: 'Connection timed out.' ] ]