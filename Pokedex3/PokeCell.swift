//
//  PokeCell.swift
//  Pokedex3
//
//  Created by Faizan on 10/3/16.
//  Copyright © 2016 Faizan. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl : UILabel!
    
    
    func configureCell(_ pokemon: Pokemon)
    {
        nameLbl.text = pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(pokemon.pokedexId)")
        
    }
    
}
