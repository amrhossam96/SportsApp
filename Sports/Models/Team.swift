//
//  Team.swift
//  Sports
//
//  Created by Amr Hossam on 27/02/2022.
//

import Foundation

struct TeamResponse: Codable {
    let teams: [Team]
}

struct Team: Codable {
    let idTeam: String?
    let strTeam: String?
    let strSport: String?
    let strLeague: String?
    let idLeague: String?
    let intFormedYear: String?
    let strStadium: String?
    let strTeamBadge: String?
    let strStadiumThumb: String?
}
