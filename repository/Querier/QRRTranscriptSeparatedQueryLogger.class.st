Class {
	#name : #QRRTranscriptSeparatedQueryLogger,
	#superclass : #QRRQueryLogger,
	#category : 'Querier-Logging'
}

{ #category : #api }
QRRTranscriptSeparatedQueryLogger >> log: queryString [
	Transcript
		cr;
		show: '-------------------------'; cr;
		show: queryString; cr;
		show: '-------------------------'; cr
]
