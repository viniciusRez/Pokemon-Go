//
//  ConsumoApi.swift
//  Pokemon Go
//
//  Created by Vinicius Rezende on 13/01/23.
//

import Foundation
import Alamofire
struct Pokemons: Decodable{
    let number:String?
    let name:String?
    let sprite:String?
    let description:String?
    enum CodingKeys: CodingKey {
        case number
        case name
        case sprite
        case description
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.number = try container.decodeIfPresent(String.self, forKey: .number)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.sprite = try container.decodeIfPresent(String.self, forKey: .sprite)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
    }
}
class ConsumoApi{
    
    
    func requestAPI(id:String,completion: @escaping([Pokemons]) -> Void){
        let request = AF.request("https://pokeapi.glitch.me/v1/pokemon/\(id)")
        request.responseDecodable(of: [Pokemons].self) { response in
            if let request = response.value {
                completion(request)
            }
        }
        
    }
}
