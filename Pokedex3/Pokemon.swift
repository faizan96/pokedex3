
//
//  Pokemon.swift
//  Pokedex3
//
//  Created by Faizan on 10/3/16.
//  Copyright © 2016 Faizan. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon
{

    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _nextEvo: String!
    private var _pokemonUrl: String!
    
    
    var name: String
    {
            return _name
    }
    
    var pokedexId: Int
    {
        return _pokedexId
    }

    
    init(name: String, pokedexId : Int )
    {
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)"
    }

    var nextEvolutionText: String {
        
        if _nextEvo == nil {
            
            _nextEvo = ""
        }
        return _nextEvo
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
    
    var description: String {
        
        if _description == nil {
            
            _description = ""
        }
        return _description
    }
    
    
    
    func downloadPokemonDetail(completed : @escaping DownloadComplete)
    {
        Alamofire.request(_pokemonUrl).responseJSON { (response) in
            
           if let dict = response.result.value as? Dictionary<String,AnyObject>
                {
                    if let defense = dict["defense"] as? Int
                    {
                        self._defense = "\(defense)"
                    }
                    
                    if let types = dict["types"] as? [Dictionary<String,String>] , types.count > 0
                    {
                        if let name = types[0]["name"]
                        {
                            self._type = name.capitalized
                        }
                        
                        if types.count > 1
                        {
                            for x in 1..<types.count
                            {
                               if let name = types[x]["name"]
                               {
                                self._type = "/\(name.capitalized)"
                                }
                            }
                        }
                        
                    }
                    else
                    {
                        self._type = "Nothing"
                    }
                    if let descArr = dict["descriptions"] as? [Dictionary<String, String>] , descArr.count > 0 {
                        
                        if let url = descArr[0]["resource_uri"] {
                            
                            let descURL = "\(URL_BASE)\(url)"
                            
                            Alamofire.request(descURL).responseJSON(completionHandler: { (response) in
                                
                                if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                    
                                    if let description = descDict["description"] as? String {
                                        
                                        let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                        
                                        self._description = newDescription
                                        print(newDescription)
                                    }
                                }
                                
                                completed()
                            })
                        }
                    } else {
                        
                        self._description = ""
                    }
                }
            
        }
        completed()
        
    }
    
    
    
    
    
    
    
}
