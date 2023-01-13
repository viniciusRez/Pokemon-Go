//
//  PresenterMain.swift
//  TrabalhandoMapas
//
//  Created by Vinicius Rezende on 29/12/22.
//

import UIKit
import MapKit
 import CoreData

class LocationViewModel {
    
    func getRegiao(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> MKCoordinateRegion {
        
        let location = Localizacao(latitude: latitude, longitude: longitude)
        let areaVizualizacao: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: location.deltalatitude, longitudeDelta: location.deltalongitude)
        
        let regiao: MKCoordinateRegion = MKCoordinateRegion(center: location.localizacao,span: areaVizualizacao)
        return regiao
    }
    func showPokemons(coordinate:CLLocationCoordinate2D) -> ModelPokemonLocation {
        let pokemonPosition = ModelPokemonLocation(coordinate: coordinate, pokemon: selectRadomPokemon())
        
        pokemonPosition.coordinate.latitude += (Double(arc4random_uniform(400)) - 250) / 100000.0
        pokemonPosition.coordinate.longitude += (Double(arc4random_uniform(400)) - 250) / 100000.0
        
        return pokemonPosition
        
    }
    func selectRadomPokemon() -> Pokemon {
        let coreDataPokemon = CoreDataPokemon()
        let listOfPokemon = coreDataPokemon.returnPokemons()
        let QPokemons = UInt32(listOfPokemon.count)
        let randomPokemon = arc4random_uniform(QPokemons)
        let pokemon = listOfPokemon[Int(randomPokemon)]
        return pokemon
                      
    }
    func capturePokemon(pokemon: Pokemon,captured:Bool)-> UIAlertController{
        if captured{
            let pokemonCoreData = CoreDataPokemon()
            let context = pokemonCoreData.getContext()
            pokemon.capturado = true
            do{
                try context.save()
            }catch{
                
            }
            let alertaController = UIAlertController(title: "Parabéns!!!",
                                                     message: "O Pokemom foi capturado com sucesso", preferredStyle: .alert)
            let acaoCapturado = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertaController.addAction(acaoCapturado)
            
            return alertaController
        }else{
            let alertaController = UIAlertController(title: "Pokemon Não Foi Capturado!!!",
                                                     message: "O pokemon esta muito longe, chegue mais perto!!", preferredStyle: .alert)
            
            let acaoNaoCapturado = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertaController.addAction(acaoNaoCapturado)
            
            return alertaController
        }
        
    }
    
}
