//
//  Country.swift
//  Sports
//
//  Created by Amr Hossam on 24/02/2022.
//

import Foundation

struct CountriesResponse: Codable {
    let countries: [Country]
}


struct Country: Codable {
    let name_en: String
}
