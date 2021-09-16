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
			baseline: 'PostgresV2'
			with: [ spec repository: 'github://JanBliznicenko/PostgresV2' ];
			baseline: 'P3' with: [ spec repository: 'github://svenvc/P3' ];
			package: 'Querier';
			package: 'Querier-PostgreSQLv2'
			with: [ spec requires: #( 'PostgresV2' 'Querier' ) ];
			package: 'Querier-PostgreSQLv3'
			with: [ spec requires: #( 'P3' 'Querier' ) ];
			group: 'v2' with: #( 'Querier-PostgreSQLv2' );
			group: 'v3' with: #( 'Querier-PostgreSQLv3' );
			group: 'default' with: #( 'v2' ) ]
]
