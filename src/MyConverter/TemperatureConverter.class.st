Class {
	#name : #TemperatureConverter,
	#superclass : #Object,
	#instVars : [
		'location',
		'measures'
	],
	#category : #MyConverter
}

{ #category : #'as yet unclassified' }
TemperatureConverter >> convertCelsius: anInteger [
"Convert anInteger from celsius to fahrenheit"

	^ ((anInteger * 1.8) + 32)
]

{ #category : #'as yet unclassified' }
TemperatureConverter >> convertFahrenheit: anInteger [
"Convert anInteger from fahrenheit to celsius"
	
	^((anInteger - 32)/1.8)
]

{ #category : #'as yet unclassified' }
TemperatureConverter >> convertFarhenheitFrom: low to: high by: step [
"Returns a collection of pairs (f, c) for all the fahrenheit temperatures from a low to an high temperature"

	^ (low to: high by: step)
		collect: [ :f | f -> (self convertFahrenheit: f) ]
]

{ #category : #initialization }
TemperatureConverter >> dates [
	^ measures collect: [ :each | each key asDate ]
]

{ #category : #initialization }
TemperatureConverter >> initialize [ 
	location := 'Nice'.
	measures := OrderedCollection new
]

{ #category : #initialization }
TemperatureConverter >> location [
 	^ location
]

{ #category : #initialization }
TemperatureConverter >> location: aPlace [
 	location := aPlace 
]

{ #category : #initialization }
TemperatureConverter >> measureCelsius: aTemp [
	measures add: DateAndTime now -> aTemp
]

{ #category : #initialization }
TemperatureConverter >> measureCount [
	^ measures size
]

{ #category : #initialization }
TemperatureConverter >> measureFahrenheit: aTemp [
	measures add: DateAndTime now -> aTemp
]

{ #category : #initialization }
TemperatureConverter >> temperatures [
	^ measures collect: [ :each | each value ]
]

{ #category : #initialization }
TemperatureConverter >> temperaturesFahrenheit [
	^ measures collect: [ :each | self convertFahrenheit:  each value ]
]

{ #category : #initialization }
TemperatureConverter >> times [
	^ measures collect: [ :each | each key asTime ]
]
