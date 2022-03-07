//
//  Event.swift
//  Sports
//
//  Created by Amr Hossam on 26/02/2022.
//

import Foundation

struct EventResponse: Codable {
    let events: [Event]
}

struct Event: Codable {
    let idEvent: String
    let idHomeTeam: String
    let idAwayTeam: String
    let strEvent: String
    let idLeague: String
    let strHomeTeam: String
    let strAwayTeam: String
    let strLeague: String
    let intHomeScore: String?
    let intAwayScore: String?
    let strThumb: String?
    let dateEvent: String
    let strTime: String
    let strStatus: String
}
