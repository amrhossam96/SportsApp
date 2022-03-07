//
//  TableStanding.swift
//  Sports
//
//  Created by Amr Hossam on 02/03/2022.
//

import Foundation

struct TableStandingResponse: Codable {
    let table: [TableStanding]
}

struct TableStanding: Codable {
    let idStanding: String
    let intRank: String
    let idTeam: String
    let strTeam: String
    let strTeamBadge: String
    let idLeague: String
    let strLeague: String
    let strSeason: String
    let intPlayed: String
    let intWin: String
    let intLoss: String
    let intDraw: String
    let intGoalsFor: String
    let intGoalsAgainst: String
    let intGoalDifference: String
    let intPoints: String
    let dateUpdated: String
}
