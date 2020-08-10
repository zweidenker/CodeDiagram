Class {
	#name : #CDTestState1,
	#superclass : #Object,
	#category : #'Flow-Core-Tests'
}

{ #category : #'as yet unclassified' }
CDTestState1 >> decision1 [
	<flow: #test1 element: #decision label: 'is it?' outgoing: #(CDTestState1 yes CDTestState1 no)>
]

{ #category : #'as yet unclassified' }
CDTestState1 >> no [
	<flow: #test1 element: #state label: 'no' outgoing: #(CDTestEnd theEnd)>
]

{ #category : #'as yet unclassified' }
CDTestState1 >> yes [
	<flow: #test1 element: #state label: 'yes' outgoing: #(CDTestState2 endTwo)>
]
