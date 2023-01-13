//
//  PokemonsTableViewCell.swift
//  Pokemon Go
//
//  Created by Vinicius Rezende on 12/01/23.
//

import UIKit

class PokemonsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var nomePokemon: UILabel!
    
    @IBOutlet weak var imgPokemon: UIImageView!
}
