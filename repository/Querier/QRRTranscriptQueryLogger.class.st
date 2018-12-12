Class {
	#name : #QRRTranscriptQueryLogger,
	#superclass : #QRRQueryLogger,
	#category : 'Querier-Logging'
}

{ #category : #api }
QRRTranscriptQueryLogger >> log: queryString [
	Transcript show: queryString; cr
]
