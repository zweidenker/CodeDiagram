Class {
	#name : #CDFlowVisitor,
	#superclass : #Object,
	#instVars : [
		'seen'
	],
	#category : #'Flow-Core'
}

{ #category : #initialization }
CDFlowVisitor >> initialize [ 	
	super initialize.
	seen := OrderedDictionary new
]

{ #category : #visiting }
CDFlowVisitor >> visit: aState [ 
	aState ifNil: [ ^ aState ].
	^ seen 
		at: aState
		ifAbsent: [ 
			seen at: aState put: Object new.
			aState acceptStateVisitor: self ]
]

{ #category : #visiting }
CDFlowVisitor >> visitAction: anAction [ 
	self visitFlowEntity: anAction 
]

{ #category : #visiting }
CDFlowVisitor >> visitCondition: aCondition [ 

	self visit: aCondition yes.
	self visit: aCondition no.
]

{ #category : #visiting }
CDFlowVisitor >> visitEnd: anEndState [ 
]

{ #category : #visiting }
CDFlowVisitor >> visitFlowEntity: aFlowEntity [ 
	self visit: aFlowEntity outgoing
]

{ #category : #visiting }
CDFlowVisitor >> visitStartState: aStartState [ 
	self visitFlowEntity: aStartState 
]

{ #category : #visiting }
CDFlowVisitor >> visitState: aState [ 
	self visitFlowEntity: aState 
]
