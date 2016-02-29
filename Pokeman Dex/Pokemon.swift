//
//  Pokemon.swift
//  Pokemon Dex
//
//  Created by Gregory DeNinno on 2/28/16.
//  Copyright © 2016 gpdno. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name: String, id: Int) {
        self._name = name
        self._pokedexId = id
    }
}