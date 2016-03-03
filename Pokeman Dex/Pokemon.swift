//
//  Pokemon.swift
//  Pokemon Dex
//
//  Created by Gregory DeNinno on 2/28/16.
//  Copyright © 2016 gpdno. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _pokedexId: Int!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvoDesc: String!
    private var _nextEvoId: String!
    private var _nextEvoLvl: String!
    private var _pokemonUrl: String!
    
    
    var name: String {
        if _name == nil {
            _name = ""
        }
        return _name
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }

    var nextEvoDesc: String {
        if _nextEvoDesc == nil {
            _nextEvoDesc = ""
        }
        return _nextEvoDesc
    }
    
    var nextEvoId: String {
        if _nextEvoId == nil {
            _nextEvoId = ""
        }
        return _nextEvoId
    }
    
    var nextEvoLvl: String {
        if _nextEvoLvl == nil {
            _nextEvoLvl = ""
        }
        return _nextEvoLvl
    }
    
    var pokemonUrl: String {
        if _pokemonUrl == nil {
            _pokemonUrl = ""
        }
        return _pokemonUrl
    }

    
    init(name: String, id: Int) {
        self._name = name
        self._pokedexId = id
        
        self._pokemonUrl = "\(BASE_URL)\(POKEMON_URL)/\(self.pokedexId)/"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        
        let url = NSURL(string: "\(_pokemonUrl)")!
        Alamofire.request(.GET, url)
            .responseJSON { response in
//                print(response.request)  // original URL request
//                print(response.response) // URL response
//                print(response.data)     // server data
//                print(response.result)   // result of response serialization
//                
//                if let JSON = response.result.value {
//                    print("JSON: \(JSON)")
//                }
                if let dict = response.result.value as? Dictionary<String, AnyObject> {
                    if let weight = dict["weight"] as? String {
                        self._weight = weight
                    }
                    if let height = dict["height"] as? String {
                        self._height = height
                    }
                    if let attack = dict["attack"] as? Int {
                        self._attack = "\(attack)"
                    }
                    if let defense = dict["defense"] as? Int {
                        self._defense = "\(defense)"
                    }
                    if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    
                        if let name = types[0]["name"] {
                            self._type = name.capitalizedString
                        }
                        
                        if types.count > 1 {
                            for var x = 1; x < types.count; x++ {
                                if let name = types[x]["name"] {
                                    self._type! += "/\(name.capitalizedString)"
                                }
                            }
                        }
                    } else {
                        self._type = ""
                    }
                    
                    if let descArr = dict["descriptions"]! as? [Dictionary<String, AnyObject>] where descArr.count > 0 {
        
                        if let url = descArr[0]["resource_uri"] {
                        
                            let nsurl = NSURL(string: "\(BASE_URL)\(url)")!
                            
                            Alamofire.request(.GET, nsurl).responseJSON { response in
                                if let desResult = response.result.value as? Dictionary<String, AnyObject>  {
                                    if let description = desResult["description"] as? String {
                                        self._description = description
                                    }
                                }
                                completed()
                            }
                            
                        }
                        
                    } else {
                        self._description = ""
                    }
                    
                    if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0 {
                        if let evolveTo = evolutions[0]["to"] as? String {
                            if evolveTo.rangeOfString("mega") == nil {
                                if let str = evolutions[0]["resource_uri"] as? String {
                                    let newStr = str.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                    let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                    self._nextEvoId = num
                                    self._nextEvoDesc = evolveTo
                                    
                                    if let lvl = evolutions[0]["level"] as? Int {
                                        self._nextEvoLvl = "\(lvl)"
                                    }
                                }
                            }
                        }
                    }
                }

        }
        
    }
}