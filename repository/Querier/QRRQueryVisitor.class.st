Class {
	#name : #QRRQueryVisitor,
	#superclass : #Object,
	#category : 'Querier-Queries-Visitors'
}

{ #category : #visiting }
QRRQueryVisitor >> visit: aQueryComponent with: aStream [
	^ aQueryComponent accept: self with: aStream
]

{ #category : #'visiting - queries' }
QRRQueryVisitor >> visitDeleteQuery: aQuery with: anObject [
	^ self visitQuery: aQuery with: anObject
]

{ #category : #'visiting - queries' }
QRRQueryVisitor >> visitInsertQuery: aQuery with: anObject [
	^ self visitQuery: aQuery with: anObject
]

{ #category : #'visiting - queries' }
QRRQueryVisitor >> visitQuery: aQuery with: anObject [
	^ self visitQueryComponent: aQuery with: anObject
]

{ #category : #'visiting - operations' }
QRRQueryVisitor >> visitQueryAdditionOperation: aQueryOperation with: anObject [
	^ self visitQueryArithmeticOperation: aQueryOperation with: anObject
]

{ #category : #'visiting - conditions' }
QRRQueryVisitor >> visitQueryAndCondition: aQueryCondition with: anObject [
	^ self visitQueryCondition: aQueryCondition with: anObject
]

{ #category : #'visiting - operations' }
QRRQueryVisitor >> visitQueryArithmeticOperation: aQueryOperation with: anObject [
	^ self visitQueryBinaryOperation: aQueryOperation with: anObject
]

{ #category : #'visiting - operations' }
QRRQueryVisitor >> visitQueryAssignmentOperation: aQueryOperation with: anObject [
	^ self visitQueryBinaryOperation: aQueryOperation with: anObject
]

{ #category : #'visiting - operations' }
QRRQueryVisitor >> visitQueryBinaryOperation: aQueryOperation with: anObject [
	^ self visitQueryOperation: aQueryOperation with: anObject
]

{ #category : #'visiting - expressions' }
QRRQueryVisitor >> visitQueryCollectionConstant: aQueryConstant with: anObject [
	^ self visitQueryConstant: aQueryConstant with: anObject
]

{ #category : #'visiting - expressions' }
QRRQueryVisitor >> visitQueryColumn: aQueryColumn with: anObject [
	^ self visitQueryComponent: aQueryColumn with: anObject
]

{ #category : #'visiting - operations' }
QRRQueryVisitor >> visitQueryComparison: aQueryOperation with: anObject [
	^ self visitQueryBinaryOperation: aQueryOperation with: anObject
]

{ #category : #visiting }
QRRQueryVisitor >> visitQueryComponent: aQueryComponent with: anObject [
	self subclassResponsibility
]

{ #category : #'visiting - conditions' }
QRRQueryVisitor >> visitQueryCondition: aQueryCondition with: anObject [
	^ self visitQueryOperation: aQueryCondition with: anObject
]

{ #category : #'visiting - expressions' }
QRRQueryVisitor >> visitQueryConstant: aQueryConstant with: anObject [
	^ self visitQueryLiteral: aQueryConstant with: anObject
]

{ #category : #'visiting - operations' }
QRRQueryVisitor >> visitQueryDistinctOperation: aQueryOperation with: anObject [
	^ self visitQueryUnaryOperation: aQueryOperation with: anObject
]

{ #category : #'visiting - operations' }
QRRQueryVisitor >> visitQueryDivisionOperation: aQueryOperation with: anObject [
	^ self visitQueryArithmeticOperation: aQueryOperation with: anObject
]

{ #category : #'visiting - operations' }
QRRQueryVisitor >> visitQueryEqualComparison: aQueryOperation with: anObject [
	^ self visitQueryComparison: aQueryOperation with: anObject
]

{ #category : #'visiting - operations' }
QRRQueryVisitor >> visitQueryExistenceOperation: aQueryOperation with: anObject [
	^ self visitQueryBinaryOperation: aQueryOperation with: anObject
]

{ #category : #'visiting - expressions' }
QRRQueryVisitor >> visitQueryExpression: aQueryExpression with: anObject [
	^ self visitQueryComponent: aQueryExpression with: anObject
]

{ #category : #'visiting - expressions' }
QRRQueryVisitor >> visitQueryExternalColumn: aQueryColumn with: anObject [
	^ self visitQueryColumn: aQueryColumn with: anObject
]

{ #category : #'visiting - functions' }
QRRQueryVisitor >> visitQueryFunction: aQueryFunction with: anObject [
	^ self visitQueryOperation: aQueryFunction with: anObject
]

{ #category : #'visiting - query parts' }
QRRQueryVisitor >> visitQueryGrouping: aQueryGrouping with: anObject [
	^ self visitQueryPart: aQueryGrouping with: anObject
]

{ #category : #'visiting - expressions' }
QRRQueryVisitor >> visitQueryIdentifier: aQueryIdentifier with: anObject [
	^ self visitQueryLiteral: aQueryIdentifier with: anObject
]

{ #category : #'visiting - operations' }
QRRQueryVisitor >> visitQueryInclusionOperation: aQueryOperation with: anObject [
	^ self visitQueryBinaryOperation: aQueryOperation with: anObject
]

{ #category : #'visiting - operations' }
QRRQueryVisitor >> visitQueryIsNotNullOperation: aQueryOperation with: anObject [
	^ self visitQueryUnaryOperation: aQueryOperation with: anObject
]

{ #category : #'visiting - operations' }
QRRQueryVisitor >> visitQueryIsNullOperation: aQueryOperation with: anObject [
	^ self visitQueryUnaryOperation: aQueryOperation with: anObject
]

{ #category : #'visiting - query parts' }
QRRQueryVisitor >> visitQueryJoin: aQueryJoin with: anObject [
	^ self visitQueryPart: aQueryJoin with: anObject
]

{ #category : #'visiting - operations' }
QRRQueryVisitor >> visitQueryLessThanComparison: aQueryOperation with: anObject [
	^ self visitQueryComparison: aQueryOperation with: anObject
]

{ #category : #'visiting - operations' }
QRRQueryVisitor >> visitQueryLessThanOrEqualComparison: aQueryOperation with: anObject [
	^ self visitQueryComparison: aQueryOperation with: anObject
]

{ #category : #'visiting - operations' }
QRRQueryVisitor >> visitQueryLikeOperation: aQueryOperation with: anObject [
	^ self visitQueryBinaryOperation: aQueryOperation with: anObject
]

{ #category : #'visiting - query parts' }
QRRQueryVisitor >> visitQueryLimit: aQueryLimit with: anObject [
	^ self visitQueryPart: aQueryLimit with: anObject
]

{ #category : #'visiting - expressions' }
QRRQueryVisitor >> visitQueryLiteral: aQueryLiteral with: anObject [
	^ self visitQueryExpression: aQueryLiteral with: anObject
]

{ #category : #'visiting - operations' }
QRRQueryVisitor >> visitQueryMoreThanComparison: aQueryOperation with: anObject [
	^ self visitQueryComparison: aQueryOperation with: anObject
]

{ #category : #'visiting - operations' }
QRRQueryVisitor >> visitQueryMoreThanOrEqualComparison: aQueryOperation with: anObject [
	^ self visitQueryComparison: aQueryOperation with: anObject
]

{ #category : #'visiting - operations' }
QRRQueryVisitor >> visitQueryMultiplicationOperation: aQueryOperation with: anObject [
	^ self visitQueryArithmeticOperation: aQueryOperation with: anObject
]

{ #category : #'visiting - expressions' }
QRRQueryVisitor >> visitQueryNestedQuery: aNestedQuery with: anObject [
	^ self visitQueryLiteral: aNestedQuery with: anObject
]

{ #category : #'visiting - operations' }
QRRQueryVisitor >> visitQueryNonExistenceOperation: aQueryOperation with: anObject [
	^ self visitQueryBinaryOperation: aQueryOperation with: anObject
]

{ #category : #'visiting - operations' }
QRRQueryVisitor >> visitQueryNonInclusionOperation: aQueryOperation with: anObject [
	^ self visitQueryBinaryOperation: aQueryOperation with: anObject
]

{ #category : #'visiting - operations' }
QRRQueryVisitor >> visitQueryNotEqualComparison: aQueryOperation with: anObject [
	^ self visitQueryComparison: aQueryOperation with: anObject
]

{ #category : #'visiting - operations' }
QRRQueryVisitor >> visitQueryNotOperation: aQueryOperation with: anObject [
	^ self visitQueryUnaryOperation: aQueryOperation with: anObject
]

{ #category : #'visiting - expressions' }
QRRQueryVisitor >> visitQueryNumberConstant: aQueryConstant with: anObject [
	^ self visitQueryConstant: aQueryConstant with: anObject
]

{ #category : #'visiting - operations' }
QRRQueryVisitor >> visitQueryOperation: aQueryOperation with: anObject [
	^ self visitQueryExpression: aQueryOperation with: anObject
]

{ #category : #'visiting - conditions' }
QRRQueryVisitor >> visitQueryOrCondition: aQueryCondition with: anObject [
	^ self visitQueryCondition: aQueryCondition with: anObject
]

{ #category : #'visiting - query parts' }
QRRQueryVisitor >> visitQueryOrdering: aQueryOrdering with: anObject [
	^ self visitQueryPart: aQueryOrdering with: anObject
]

{ #category : #'visiting - query parts' }
QRRQueryVisitor >> visitQueryPart: aQueryPart with: anObject [
	^ self visitQueryComponent: aQueryPart with: anObject
]

{ #category : #'visiting - expressions' }
QRRQueryVisitor >> visitQuerySimpleColumn: aQueryConstant with: anObject [
	^ self visitQueryConstant: aQueryConstant with: anObject
]

{ #category : #'visiting - expressions' }
QRRQueryVisitor >> visitQueryStringConstant: aQueryConstant with: anObject [
	^ self visitQueryConstant: aQueryConstant with: anObject
]

{ #category : #'visiting - operations' }
QRRQueryVisitor >> visitQuerySubtractionOperation: aQueryOperation with: anObject [
	^ self visitQueryArithmeticOperation: aQueryOperation with: anObject
]

{ #category : #'visiting - functions' }
QRRQueryVisitor >> visitQueryUnaryFunction: aQueryFunction with: anObject [
	^ self visitQueryFunction: aQueryFunction with: anObject
]

{ #category : #'visiting - operations' }
QRRQueryVisitor >> visitQueryUnaryOperation: aQueryOperation with: anObject [
	^ self visitQueryOperation: aQueryOperation with: anObject
]

{ #category : #'visiting - functions' }
QRRQueryVisitor >> visitQueryVariadicFunction: aQueryFunction with: anObject [
	^ self visitQueryFunction: aQueryFunction with: anObject
]

{ #category : #'visiting - operations' }
QRRQueryVisitor >> visitQueryVariadicOperation: aQueryOperation with: anObject [
	^ self visitQueryOperation: aQueryOperation with: anObject
]

{ #category : #'visiting - queries' }
QRRQueryVisitor >> visitSelectQuery: aQuery with: anObject [
	^ self visitQuery: aQuery with: anObject
]

{ #category : #'visiting - queries' }
QRRQueryVisitor >> visitUpdateQuery: aQuery with: anObject [
	^ self visitQuery: aQuery with: anObject
]
