visiting - conditions
visitQueryCondition: aQueryCondition separatedBy: separatorString with: aStream
	"If there are no conditions, pass a placeholder (always-true expression)."
	aQueryCondition isEmpty
		ifTrue: [
			aStream nextPutAll: 'true'.
			^ self ].
	
	self
		parenthesized: [
			aQueryCondition
				conditionsDo: [ :condition |
					self visit: condition with: aStream ]
				separatedBy: [
					aStream nextPutAll: separatorString ] ]
		on: aStream