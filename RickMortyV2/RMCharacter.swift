//
//  RMCharacter.swift
//  RickMortyV2
//
//  Created by Jugurtha Kabeche on 25/11/2021.
//

import Foundation
import ObjectMapper

class RMCharacter: Mappable {
    var id: Int?
    var name: String?
    var status: String?
    var species: String?
    var image: String?
    var originName: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.name <- map["name"]
        self.status <- map["status"]
        self.species <- map["species"]
        self.image <- map["image"]
        self.originName <- map["origin.name"]
    }
}
