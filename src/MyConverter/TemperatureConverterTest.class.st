Class {
	#name : #TemperatureConverterTest,
	#superclass : #TestCase,
	#category : #MyConverter
}

{ #category : #tests }
TemperatureConverterTest >> testCelsiusToFahrenheit [
	| converter |
	converter := TemperatureConverter new.
	self assert: (converter convertCelsius: 30) equals: 86.0
]

{ #category : #tests }
TemperatureConverterTest >> testFToCScale [
	| converter results expectedCelsius |
	converter := TemperatureConverter new.
	results := (converter convertFarhenheitFrom: 50 to: 70 by: 2).
	expectedCelsius := #(10.0 11.1 12.2 13.3 14.4 15.5 16.6 17.7 18.8
		20.0 21.1).
		
	results with: expectedCelsius
		do: [ :res :cel | res value closeTo: cel ]
]

{ #category : #tests }
TemperatureConverterTest >> testFahrenheitToCelsius [
	| converter |
	converter := TemperatureConverter new.
	self assert: ((converter convertFahrenheit: 86) closeTo: 30.0 precision: 0.1).
	self assert: ((converter convertFahrenheit: 50) closeTo: 10 precision: 0.1)
]

{ #category : #tests }
TemperatureConverterTest >> testLocationAndDate [
	| office |
	office := TemperatureConverter new location: 'Office'.
	"perform two measures that are logged"
	office measureCelsius: 19.
	office measureCelsius: 21.

	"We got effectively two measures"
	self assert: office measureCount equals: 2.
	
	"All the measures were done today"
	self assert: office dates equals: {Date today . Date today}
		asOrderedCollection.
		
	"We logged the correct temperature"
	self assert: office temperatures equals: { 19 . 21 }
		asOrderedCollection
]

{ #category : #tests }
TemperatureConverterTest >> testLocationAndDateWithConversion [

	| converter |
	
	converter := TemperatureConverter new location: 'Lille'.
	
	converter measureFahrenheit: 86.
	converter measureFahrenheit: 50.
	
	self assert: converter measureCount equals: 2.
	
	self assert: converter dates
		equals: {Date today . Date today} asOrderedCollection.
		
	self assert: converter temperaturesFahrenheit 
		equals: { converter convertFahrenheit: 86 .
			converter convertFahrenheit: 50 } asOrderedCollection
]

{ #category : #tests }
TemperatureConverterTest >> testTwoLocations [
	| office home |
	office := TemperatureConverter new location: 'office'.
	
	office measureFahrenheit: 19.
	office measureFahrenheit: 21.
	
	self assert: office location equals: 'office'.
	self assert: office measureCount equals: 2.
	
	home := TemperatureConverter new location: 'home'.
	
	home measureFahrenheit: 22.
	home measureFahrenheit: 22.
	home measureFahrenheit: 22.
	
	self assert: home location equals: 'home'.
	self assert: home measureCount equals: 3.
]
