//
//  PokedexViewController.swift
//  Pokemon Go
//
//  Created by Vinicius Rezende on 12/01/23.
//

import UIKit


class PokedexViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "capturados"
        case 1:
            return "Não capturados"
        default:
            return "Pokemon"
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return self.pokemonsCapturados.count
        case 1:
            return self.pokemonsNaoCapturados.count
        default:
            return 0
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cellPokemon", for: indexPath) as? PokemonsTableViewCell {
            switch indexPath.section{
            case 0:
                cell.nomePokemon.text = self.pokemonsCapturados[indexPath.row].nome
                cell.imgPokemon.image = UIImage(named: self.pokemonsCapturados[indexPath.row].nomeimagem!)
            case 1:
                cell.nomePokemon.text = self.pokemonsNaoCapturados[indexPath.row].nome
                cell.imgPokemon.image = UIImage(named: self.pokemonsNaoCapturados[indexPath.row].nomeimagem!)
            default:
                return UITableViewCell()


            }
          
            return cell
        }
        return UITableViewCell()

    }
    
    var pokemonsCapturados:[Pokemon] = []
    var pokemonsNaoCapturados:[Pokemon] = []
    var viewModel: PokedexViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = PokedexViewModel()
        self.pokemonsCapturados = viewModel.getPokemonsCapturados(capturado: true)
        self.pokemonsNaoCapturados = viewModel.getPokemonsCapturados(capturado: false)
        
        // Do any additional setup after loading the view.
    }

    @IBAction func returnMapa(_ sender: Any) {
        dismiss(animated: true )
    }
}
