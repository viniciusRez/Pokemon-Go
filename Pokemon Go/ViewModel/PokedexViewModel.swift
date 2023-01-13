//
//  PokedexViewModel.swift
//  Pokemon Go
//
//  Created by Vinicius Rezende on 12/01/23.
//

import UIKit
import Foundation

class PokedexViewModel {
    func getPokemonsCapturados(capturado: Bool)-> [Pokemon] {
        let coreData = CoreDataPokemon()
        let listOfPokemons = coreData.returnPokemonsCapturados(capturado: capturado)
        return listOfPokemons
        
    }
}
