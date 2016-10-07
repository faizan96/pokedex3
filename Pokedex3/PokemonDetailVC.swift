//
//  PokemonDetailVC.swift
//  Pokedex3
//
//  Created by Faizan on 10/6/16.
//  Copyright © 2016 Faizan. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon : Pokemon!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemon.name.capitalized
        
        let img = UIImage(named: "\(pokemon.pokedexId)")
        thumbImg.image = img
        currentEvoImg.image = img
        
       pokemon.downloadPokemonDetail
        {
            self.updateUI()
        }
    }

    
    
    func updateUI()
    {
    defenseLbl.text = pokemon.defense
    typeLbl.text = pokemon.type
        descLbl.text = pokemon.description
    }
    
    
    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
