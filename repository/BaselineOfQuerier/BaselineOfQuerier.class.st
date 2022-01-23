Class {
	#name : #BaselineOfQuerier,
	#superclass : #BaselineOf,
	#category : #BaselineOfQuerier
}

{ #category : #accessing }
BaselineOfQuerier >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'P3' with: [ spec repository: 'github://svenvc/P3' ];
			package: 'Querier' with: [ spec requires: #( 'P3' ) ];
			package: 'Querier-PostgreSQL'
			with: [ spec requires: #( 'Querier' ) ] ]
]
