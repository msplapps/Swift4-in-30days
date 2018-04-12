//: # Measurements and Units
import Foundation

let cycleRide = Measurement(value: 25, unit: UnitLength.kilometers)
cycleRide.converted(to: .miles)
cycleRide.converted(to: .furlongs)

let distanceCompleted = Measurement(value: 13, unit: UnitLength.kilometers)
cycleRide - distanceCompleted


let swim = Measurement(value: 2000, unit: UnitLength.meters)

let marathon = Measurement(value: 26, unit: UnitLength.miles) + Measurement(value: 285, unit: UnitLength.yards)

let run = marathon / 2

let triathalon = cycleRide + swim + run

triathalon.converted(to: .nauticalMiles)

triathalon > cycleRide



//: ## Nuclear Fission
//: ![U235 Fission](u235_fission.png "Nuclear Fission")

func emc2(mass: Measurement<UnitMass>, speedOfLight: Measurement<UnitSpeed>) -> Measurement<UnitEnergy> {
  let energy = mass.converted(to: .kilograms).value * speedOfLight.converted(to: .metersPerSecond).value ** 2
  return Measurement(value: energy, unit: UnitEnergy.joules)
}

let amus = UnitMass(symbol: "amu", converter: UnitConverterLinear(coefficient: Constants.Masses.amu))

let massU235 = Measurement(value: Constants.Masses.u235, unit: amus)
let massNeutron = Measurement(value: Constants.Masses.neutron, unit: amus)
let massReactants = massU235 + massNeutron

let massProducts = Measurement(value: Constants.Masses.products, unit: amus)

let differenceMass = massReactants - massProducts

let speedOfLight = Measurement(value: Constants.c, unit: UnitSpeed.metersPerSecond)

let energy = emc2(mass: differenceMass, speedOfLight: speedOfLight)

let energyPerKilo = (1000 / 235 * Constants.avagadro * energy).converted(to: .kilowattHours)


//: > In the US typical household power consumption is about *11,700 kWh* each year, in France it is *6,400 kWh*, in the UK it is *4,600 kWh* and in China around *1,300 kWh*.

energyPerKilo.value / 4600

