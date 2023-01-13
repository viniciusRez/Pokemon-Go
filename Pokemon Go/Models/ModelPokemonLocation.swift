//
//  ModelPokemonLocation.swift
//  Pokemon Go
//
//  Created by Vinicius Rezende on 12/01/23.
//

import Foundation
import MapKit

class ModelPokemonLocation: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    let pokemon:Pokemon
    init(coordinate: CLLocationCoordinate2D, pokemon: Pokemon) {
        self.coordinate = coordinate
        self.pokemon = pokemon
    }
}
