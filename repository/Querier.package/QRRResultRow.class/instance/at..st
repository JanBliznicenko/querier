api
at: key
	key isArray ifTrue: [
		^ key size = 1
				ifTrue: [ self at: key first ]
				ifFalse: [ (self at: key first) at: key allButFirst ] ].
	
	values at: key ifPresent: [ :value | ^ value ].
	self referencedRowAt: key ifPresent: [ :value | ^ value ].
	
	result keyNotFound: key forValues: values.
	
	"Try again, the result might have lazy-loaded the value or the reference."
	values at: key ifPresent: [ :value | ^ value ].
	self referencedRowAt: key ifPresent: [ :value | ^ value ].
	
	"(KeyNotFound new key: key) signal."
	^ nil