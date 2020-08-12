Class {
	#name : #BaselineOfCodeDiagram,
	#superclass : #BaselineOf,
	#category : #BaselineOfCodeDiagram
}

{ #category : #baselines }
BaselineOfCodeDiagram >> baseline: spec [
	<baseline>
		
	spec for: #'common' do: [			
		spec 
			package: 'Flow-Core';
			package: 'Flow-Core-Tests' with: [ spec requires: #( 'Flow-Core' ) ];
			package: 'Flow-Roassal' with: [ spec requires: #( 'Flow-Core' 'Roassal3' 'Cassowary' ) ].

		spec
			group: 'default' with: #('Flow-Core' 'Flow-Roassal');
			group: 'Core' with: #('Flow-Core');
			group: 'UI' with: #('Flow-Roassal');
			group: 'Tests' with: #('Flow-Core-Tests').
		self 
			cassowary: spec;
			roassal3: spec. ]
]

{ #category : #baselines }
BaselineOfCodeDiagram >> cassowary: spec [
	spec
		baseline: 'Cassowary' with: [ 
			spec
				"loads: 'Core';"
				repository: 'github://noha/Cassowary/source' ]
]

{ #category : #baselines }
BaselineOfCodeDiagram >> roassal3: spec [
	spec
		baseline: 'Roassal3' with: [ 
			spec
				"loads: 'Core';"
				repository: 'github://ObjectProfile/Roassal3:v0.9.2/src' ]
]
