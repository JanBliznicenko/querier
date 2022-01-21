Class {
	#name : #BaselineOfQuerier,
	#superclass : #BaselineOf,
	#category : #BaselineOfQuerier
}

{ #category : #baselines }
BaselineOfQuerier >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'P3' with: [ spec repository: 'github://svenvc/P3' ];
			package: 'Querier';
			package: 'Querier-PostgreSQLv3'
			with: [ spec requires: #( 'P3' 'Querier' ) ];
			group: 'default' with: #( 'Querier-PostgreSQLv3' ) ]
]
