//
//  RMCharacterResponse.swift
//  RickMortyV2
//
//  Created by Jugurtha Kabeche on 25/11/2021.
//

import Foundation
import ObjectMapper
class RMCharacterResponse: Mappable {
    var results: [RMCharacter]?
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        results <- map["results"]
    }
}
