Class {
	#name : #QRRTranscriptSeparatedQueryLogger,
	#superclass : #QRRQueryLogger,
	#category : #'Querier-Logging'
}

{ #category : #api }
QRRTranscriptSeparatedQueryLogger >> log: queryString [

	Transcript
		show: '[';
		show: Time now print24;
		show: '|';
		show: ZnUtils currentProcessID asString;
		show: ']';
		show: '---------';
		cr;
		show: queryString;
		cr;
		show: '--------------------------';
		cr
]
