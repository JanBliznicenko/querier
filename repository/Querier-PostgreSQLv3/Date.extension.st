Extension { #name : #Date }

{ #category : #'*Querier-PostgreSQLv3' }
Date class >> year: year month: month day: day [

	^ self starting: (DateAndTime year: year month: month day: day)
]
