import Foundation
import CoreData
import UIKit
class CoreDataPokemon{
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate  as? AppDelegate
        if let context = appDelegate?.persistentContainer.viewContext
        {
            return context
        }
        return getContext()
    }
    func registerAllPokemons(){
        let context = self.getContext()
        
        self.registerPokemon(nome: "Mew", nomeImagem: "mew", capturado: false )
        self.registerPokemon(nome: "Meowth", nomeImagem: "meowth", capturado: false)
        self.registerPokemon(nome: "Pikachu", nomeImagem: "pikachu-2", capturado: true)
        self.registerPokemon(nome: "Squirtle", nomeImagem: "squirtle", capturado: false )
        self.registerPokemon(nome: "Charmander", nomeImagem: "charmander", capturado: false )
        self.registerPokemon(nome: "Caterpie", nomeImagem: "caterpie", capturado: false )
        self.registerPokemon(nome: "Bullbasaur", nomeImagem: "bullbasaur", capturado: false )
        self.registerPokemon(nome: "Bellsprout", nomeImagem: "bellsprout", capturado: false )
        self.registerPokemon(nome: "Psyduck", nomeImagem: "psyduck", capturado: false )
        self.registerPokemon(nome: "Rattata", nomeImagem: "rattata", capturado: false )
        self.registerPokemon(nome: "Snorlax", nomeImagem: "snorlax", capturado: false)
        self.registerPokemon(nome: "Zubat", nomeImagem: "zubat", capturado: false )

        do{
            try context.save()
        }
        catch {
            print(error)
        }
    }
    func returnPokemons() -> [Pokemon] {
        let context = self.getContext()
        do {
            let listOfPokemons = try context.fetch(Pokemon.fetchRequest()) as! [Pokemon]
            if listOfPokemons.isEmpty{
                self.registerAllPokemons()
                return returnPokemons()
                
            }else{
                return listOfPokemons
            }
        }catch{
            
        }
        return []
    }
    func returnPokemonsCapturados(capturado: Bool) -> [Pokemon] {
        let context = self.getContext()
        let request = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
        request.predicate = NSPredicate(format: "capturado = %@", NSNumber(value: capturado) )
        do {
            let listOfPokemons = try context.fetch(request) 
            if listOfPokemons.isEmpty{
                return []
            }else{
                return listOfPokemons
            }
        }catch{
            
        }
        return []
    }
    func registerPokemon(nome:String,nomeImagem:String,capturado:Bool){
        let context = self.getContext()
        let pokemon = Pokemon(context: context)
        pokemon.nome = nome
        pokemon.nomeimagem = nomeImagem
        pokemon.capturado = capturado
    }
    func capturePokemon(pokemon:Pokemon){
        let context = self.getContext()
        pokemon.capturado = true
        do{
            try context.save()
        }catch{
            
        }
    }
}
