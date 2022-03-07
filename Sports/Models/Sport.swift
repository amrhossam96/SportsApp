//
//  Sport.swift
//  Sports
//
//  Created by Amr Hossam on 24/02/2022.
//

import Foundation


struct SportResponse: Codable {
    let sports: [Sport]
}

struct Sport: Codable {
    let idSport: String
    let strSport: String
    let strSportDescription: String
    let strSportIconGreen: String
    let strSportThumb: String
}
