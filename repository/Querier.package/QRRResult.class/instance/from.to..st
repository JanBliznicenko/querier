api - limiting
from: fromInteger to: toInteger
	self limit: toInteger - fromInteger + 1.
	self offset: fromInteger - 1