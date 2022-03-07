//
//  APICaller.swift
//  Sports
//
//  Created by Amr Hossam on 24/02/2022.
//

import Foundation
import SwiftSoup
enum APICallerError: Error {
    case failedToCreateURL
    case failedToUnwrapData
    case failedToDecode
    case failedToGetUpcomingMatch
    case failedToGetTableStandings
    case failedToGetPlayer
}

class APICaller {
    
    static let shared = APICaller()
    
    func fetchSportsFromDatabase(completion: @escaping (Result<[Sport], Error>) -> Void) {
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/all_sports.php") else {
            completion(.failure(APICallerError.failedToCreateURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data else {
                completion(.failure(APICallerError.failedToUnwrapData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(SportResponse.self, from: data)
                completion(.success(result.sports))
                
            } catch {
                completion(.failure(APICallerError.failedToDecode))
            }
            
        }
        
        task.resume()
    }
    
    func getAllCountres(completion: @escaping (Result<[Country], Error>) -> Void) {
        
        
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/all_countries.php") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data else {
                return
            }

            do {
                let result = try JSONDecoder().decode(CountriesResponse.self, from: data)
                completion(.success(result.countries))
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }

    
    func getLeaguesFor(country: String, for sport: String, completion: @escaping (Result<[League], Error>) -> Void) {
        print()
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?c=\(country.replacingOccurrences(of: " ", with: "+"))&s=\(sport)") else {

            return
        }
                
        print(url.absoluteString)
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(LeagueResponse.self, from: data)
                completion(.success(result.countrys))
            } catch {
                completion(.failure(APICallerError.failedToDecode))
            }
        }
        
        task.resume()
        
    }
    
    func fetchEventsFor(leagueID: String, completion: @escaping (Result<[Event],Error>) -> Void) {
        
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/eventsseason.php?id=\(leagueID)&s=2021-2022")
            else {
                return
            }
        
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {  data, _, error in
                guard let data = data else {
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(EventResponse.self, from: data)
                    completion(.success(result.events))
                } catch {
                    print(error.localizedDescription)
                }

            }
            task.resume()
        }
        
    
    func fetchTeamsFor(league: String, completion: @escaping (Result<[Team], Error>) -> Void) {
        guard let leagueString = league.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?l=\(leagueString)") else {
            return
        }
        print(url)
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(TeamResponse.self, from: data)
                completion(.success(result.teams))
            } catch {
                completion(.failure(DatabaseError.failedToFetchData))
            }
        }
        task.resume()
    }
    
    func matches(for regex: String, in text: String) -> [String] {

        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    func getSquadForTeamWith(id: String, completion: @escaping (Result<[String], Error>) -> Void) {
        let myURLString = "https://www.thesportsdb.com/team/\(id)?cutout=1#playerImages"
        guard let myURL = URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return
        }
        var squad: [String] = [""]
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            let doc: Document = try SwiftSoup.parse(myHTMLString)
            let matches = matches(for: "/player/([^/]+)", in: doc.description)
            matches.forEach { s in
                if !(s == "/player/cutout") {
                    let parts = s.split(separator: "-")
                    var name = ""
                    for i in 0..<parts.count {
                        if i == 0 {
                            continue
                        }
                        name += parts[i] + " "
                    }
                    if !((name.dropLast().dropLast().dropLast().dropLast()) == "") {
                        squad.append("\(name.dropLast().dropLast().dropLast().dropLast().trimmingCharacters(in: CharacterSet(charactersIn: " ")))")
                    }
                }
            }
            squad.removeAll { s in
                s == ""
            }
            squad.remove(at: 0)
            completion(.success(squad))

        } catch let error {
            print("Error: \(error)")
        }
    }
    
    func getUpcomingMatchForLeagueWith(id: String, completion: @escaping (Result<[Event], Error>) -> Void) {
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/eventsround.php?id=\(id)&r=38&s=2021-2022") else {
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data else {
                return
            }
            do {
                let result = try JSONDecoder().decode(EventResponse.self, from: data)
                completion(.success(result.events))
                
            } catch {
                completion(.failure(APICallerError.failedToGetUpcomingMatch))
            }
        }
        task.resume()
    }
    
    func getStadingsForLeagureWith(id: String, completion: @escaping (Result<[TableStanding], Error>) -> Void) {
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/lookuptable.php?l=\(id)&s=2020-2021") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(TableStandingResponse.self, from: data)
                completion(.success(result.table))
            } catch {
                completion(.failure(APICallerError.failedToGetTableStandings))
            }
        }
        task.resume()
    }
    
    
    func getDetailsForPlayer(name: String, completion: @escaping (Result<Player, Error>) -> Void) {
        
        guard let name = name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
            
        }
        
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/searchplayers.php?p=\(name)") else {
            return
        }                
                let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                    guard let data = data else {
                        return
                    }
                    
                    do {
                        let result = try JSONDecoder().decode(PlayerResponse.self, from: data)
                        completion(.success(result.player[0]))
                    } catch {
                        completion(.failure(APICallerError.failedToGetPlayer))
                    }
                }
        
        task.resume()
    }
}






// table: https://www.thesportsdb.com/api/v1/json/2/lookuptable.php?l=4328&s=2020-2021

// team players: https://www.thesportsdb.com/team/134355?cutout=1#playerImages
