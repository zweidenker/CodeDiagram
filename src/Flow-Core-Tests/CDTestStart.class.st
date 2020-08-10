Class {
	#name : #CDTestStart,
	#superclass : #Object,
	#category : #'Flow-Core-Tests'
}

{ #category : #tests }
CDTestStart >> test1 [ 
	<flow: #test1 element: #start label: 'Start' outgoing: #self>
	<flow: #test1 element: #state label: 'State1' outgoing: #(CDTestState1 decision1)>
]
