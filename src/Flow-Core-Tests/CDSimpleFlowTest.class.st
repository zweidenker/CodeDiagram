Class {
	#name : #CDSimpleFlowTest,
	#superclass : #CDFlowTest,
	#category : #'Flow-Core-Tests'
}

{ #category : #tests }
CDSimpleFlowTest >> flowName [
	^ #test1
]

{ #category : #tests }
CDSimpleFlowTest >> flowStartClass [
	^ CDTestStart 
]

{ #category : #tests }
CDSimpleFlowTest >> flowStartSelector [
	^ #test1
]

{ #category : #tests }
CDSimpleFlowTest >> testJoinOnEnd [
	self assert: model class equals: CDStartState.
	self assert: model outgoing class equals: CDState 
]

{ #category : #tests }
CDSimpleFlowTest >> testStartEntity [
	self assert: model class equals: CDStartState.
	self assert: model outgoing class equals: CDState 
]
