//
//  Player.swift
//  Sports
//
//  Created by Amr Hossam on 03/03/2022.
//

import Foundation


struct PlayerResponse: Codable {
    let player: [Player]
}


struct Player: Codable {
    let idTeam: String
    let strNationality: String
    let strPlayer: String
    let strTeam: String
    let strSport: String
    let dateBorn: String?
    let strNumber: String?
    let dateSigned: String?
    let strWage: String?
    let strKit: String?
    let strBirthLocation: String
    let strDescriptionEN: String
    let strCutout: String
}

//public struct PlayerResponse: Codable {
//    public let player: [[String: String?]]
//
//    public init(player: [[String: String?]]) {
//        self.player = player
//    }
//}
