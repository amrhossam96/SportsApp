//
//  League.swift
//  Sports
//
//  Created by Amr Hossam on 24/02/2022.
//

import Foundation


struct LeagueResponse: Codable {
    let countrys: [League]
}

struct League: Codable {
    let strLeague: String
    let strCountry: String
    let strDescriptionEN: String
    let strBadge: String
    let idLeague: String
}
