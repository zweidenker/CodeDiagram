Class {
	#name : #CDSimpleJoinStateTest,
	#superclass : #CDFlowTest,
	#category : #'Flow-Core-Tests'
}

{ #category : #tests }
CDSimpleJoinStateTest >> flowName [
	^ #joinState
]

{ #category : #tests }
CDSimpleJoinStateTest >> flowStartClass [
	^ CDTestStart 
]

{ #category : #tests }
CDSimpleJoinStateTest >> flowStartSelector [
	^ #joinState
]

{ #category : #tests }
CDSimpleJoinStateTest >> testJoinOnEnd [
	self assert: model class equals: CDStartState.
	self assert: model outgoing class equals: CDDecision. 
	self assert: model outgoing yes outgoing equals: model outgoing no outgoing
]
