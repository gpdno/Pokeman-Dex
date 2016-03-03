//
//  PokemomDetailVC.swift
//  Pokeman Dex
//
//  Created by Gregory DeNinno on 2/29/16.
//  Copyright © 2016 gpdno. All rights reserved.
//

import UIKit

class PokemomDetailVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokedexIdLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var baseAttackLabel: UILabel!
    @IBOutlet weak var evoLabel: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    
    var pokemon: Pokemon!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = pokemon.name
        mainImg.image = UIImage(named: "\(pokemon.pokedexId)")
        
        pokemon.downloadPokemonDetails { () -> () in
        self.updateUi()
        }
    }
    
    func updateUi() {
        descriptionLabel.text = pokemon.description
        typeLabel.text = pokemon.type
        pokedexIdLabel.text = "\(pokemon.pokedexId)"
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        baseAttackLabel.text = pokemon.attack
        
        if pokemon.nextEvoId == "" {
            evoLabel.text = "No evolutions"
            currentEvoImg.hidden = true
            nextEvoImg.hidden = true
        } else {
            currentEvoImg.hidden = false
            nextEvoImg.hidden = false
            currentEvoImg.image = UIImage(named: "\(pokemon.pokedexId)")
            nextEvoImg.image = UIImage(named: "\(pokemon.nextEvoId)")
            evoLabel.text = "Next evolution: \(pokemon.nextEvoDesc) - Lvl \(pokemon.nextEvoLvl)"
        }
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
