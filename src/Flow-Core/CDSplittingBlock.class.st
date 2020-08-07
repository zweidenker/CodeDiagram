Class {
	#name : #CDSplittingBlock,
	#superclass : #CDBlockObject,
	#instVars : [
		'firstBranch',
		'secondBranch'
	],
	#category : #'Flow-Core'
}

{ #category : #'as yet unclassified' }
CDSplittingBlock class >> stateObjectName [

	^ nil
]

{ #category : #accessing }
CDSplittingBlock >> firstBranch [
	^ firstBranch
]

{ #category : #accessing }
CDSplittingBlock >> firstBranch: anObject [
	anObject incoming: self.
	firstBranch := anObject
]

{ #category : #visiting }
CDSplittingBlock >> resolveOutgoing: aCollection at: index builder: aBuilder [
	firstBranch := aBuilder resolveOutgoing: (aCollection first: 2) at: index.
	firstBranch incoming: self.
	secondBranch := aBuilder resolveOutgoing:  (aCollection last: 2) at: index.
	secondBranch incoming: self
]

{ #category : #accessing }
CDSplittingBlock >> secondBranch [
	^ secondBranch
]

{ #category : #accessing }
CDSplittingBlock >> secondBranch: anObject [
	anObject incoming: self.
	secondBranch := anObject
]
