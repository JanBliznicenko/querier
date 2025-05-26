Class {
	#name : 'BaselineOfQuerier',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfQuerier',
	#package : 'BaselineOfQuerier'
}

{ #category : 'baselines' }
BaselineOfQuerier >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'P3' with: [ spec repository: 'github://svenvc/P3:baf8c3d' ];
			package: 'Querier' with: [ spec requires: #( 'P3' ) ];
			package: 'Querier-PostgreSQL'
			with: [ spec requires: #( 'Querier' ) ] ]
]
