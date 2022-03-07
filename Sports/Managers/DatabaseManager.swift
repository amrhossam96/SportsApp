//
//  DatabaseManager.swift
//  Sports
//
//  Created by Amr Hossam on 24/02/2022.
//

import Foundation
import UIKit
import CoreData


enum DatabaseError: Error {
    case failedToSave
    case failedToFetchData
    case failedToDeleteData
}

class DatabaseManager {
    static let shared = DatabaseManager()
    
    
    
    func downloadSportsToDatabase(with model: [Sport], completion: @escaping (Result<Void, Error>) -> Void) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let contextManager = appDelegate.persistentContainer.viewContext
        
        for sport in model {
            let entity = SportEntity(context: contextManager)
            entity.idSport = sport.idSport
            entity.strSport = sport.strSport
            entity.strSportThumb = sport.strSportThumb
            entity.strSportIconGreen = sport.strSportIconGreen
            entity.strSportDescription = sport.strSportDescription
            
            do {
                try contextManager.save()
                completion(.success(()))
            } catch {
                completion(.failure(DatabaseError.failedToSave))

                print(error.localizedDescription)
            }
        }
    }
    
    func downloadLeagues(with model: [LeagueTableViewModel], completion: @escaping (Result<Void, Error>) -> Void) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let contextManager = appDelegate.persistentContainer.viewContext
        
        
        for league in model {
            let item = LeagueEntity(context: contextManager)
            item.leagueID = league.leagueID
            item.leagueName = league.leagueName
            item.leagueIcon = league.leagueIcon
            
            do {
                try contextManager.save()
            } catch {
                completion(.failure(DatabaseError.failedToSave))
            }
        }
        
        completion(.success(()))
        
    }
    
    
    func fetchingLeaguesFromDataBase(completion: @escaping (Result<[LeagueEntity], Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<LeagueEntity>
        
        request = LeagueEntity.fetchRequest()
        
        do {
            
            let leagues = try context.fetch(request)
            completion(.success(leagues))
            
        } catch {
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }
    
    func deleteTitleWith(model: LeagueEntity, completion: @escaping (Result<Void, Error>)-> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToDeleteData))
        }
        
    }
    
}
