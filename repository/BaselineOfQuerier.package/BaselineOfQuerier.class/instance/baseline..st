accessing
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec
				project: 'PostgresV2'
					with: [ spec
						className: #ConfigurationOfPostgresV2;
						repository: 'http://smalltalkhub.com/mc/PharoExtras/PostgresV2/main/' ];
				package: 'Querier' with: [ spec requires: #('PostgresV2') ];
				package: 'Querier-PostgreSQL' with: [ spec requires: #('Querier') ] ]