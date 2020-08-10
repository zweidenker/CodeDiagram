Class {
	#name : #CDTestState2,
	#superclass : #Object,
	#category : #'Flow-Core-Tests'
}

{ #category : #'as yet unclassified' }
CDTestState2 >> endTwo [
	<flow: #test1 element: #state label: 'State2' outgoing: #self>
	<flow: #test1 element: #end label: 'Another end' outgoing: #()>
]

{ #category : #'as yet unclassified' }
CDTestState2 >> state2 [
	<flow: #test1 element: #state label: 'State2' outgoing: #self>
	<flow: #test1 element: #end label: 'The end' outgoing: #()>
]
