Class {
	#name : #QRRTranscriptQueryLogger,
	#superclass : #QRRQueryLogger,
	#category : #'Querier-Logging'
}

{ #category : #api }
QRRTranscriptQueryLogger >> log: queryString [

	Transcript
		show: '[';
		show: Time now print24;
		show: '|';
		show: ZnUtils currentProcessID asString;
		show: '] ';
		show: queryString;
		cr
]
