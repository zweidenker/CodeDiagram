Class {
	#name : #BaselineOfCodeDiagram,
	#superclass : #BaselineOf,
	#category : #BaselineOfCodeDiagram
}

{ #category : #baselines }
BaselineOfCodeDiagram >> baseline: spec [
	<baseline>
		
	spec for: #'common' do: [			
		spec package: 'Flow-Core' with: [ spec requires: #( 'Roassal3' ) ].

		spec
			group: 'default' with: #('Flow-Core').
		self roassal3: spec. ]
]

{ #category : #baselines }
BaselineOfCodeDiagram >> roassal3: spec [
	spec
		baseline: 'Roassal3' with: [ 
			spec
				"loads: 'Core';"
				repository: 'github://ObjectProfile/Roassal3/src' ]
]
