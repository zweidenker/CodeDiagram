Class {
	#name : #CDFlowTest,
	#superclass : #TestCase,
	#instVars : [
		'model'
	],
	#category : #'Flow-Core-Tests'
}

{ #category : #tests }
CDFlowTest >> flowName [ 
	self subclassResponsibility 
]

{ #category : #tests }
CDFlowTest >> flowStartClass [
	self subclassResponsibility 
]

{ #category : #tests }
CDFlowTest >> flowStartSelector [
	self subclassResponsibility 
]

{ #category : #tests }
CDFlowTest >> setUp [
	model := CDCodeModelBuilder new
		flowName: self flowName;
		startAt: self flowStartClass method: self flowStartSelector asSymbol;
		model
]
