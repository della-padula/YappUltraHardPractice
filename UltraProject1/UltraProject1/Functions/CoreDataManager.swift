//
//  CoreDataManager.swift
//  UltraProject1
//
//  Created by leeesangheee on 2021/09/28.
//

import CoreData
import Foundation

class CoreDataManager {
    let shared = CoreDataManager()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UltraProject1")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private var gameEntity: NSEntityDescription? {
        return  NSEntityDescription.entity(forEntityName: "GameScore", in: context)
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func insertGame(_ score: Score) {
        if let entity = gameEntity {
            let managedObject = NSManagedObject(entity: entity, insertInto: context)
            managedObject.setValue(score.total, forKey: "total")
            managedObject.setValue(score.first, forKey: "first")
            managedObject.setValue(score.second, forKey: "second")
            managedObject.setValue(score.wrong, forKey: "wrong")
        }
    }
    
    private func fetchGameScores() -> [GameScore] {
        do {
            guard let gameScores = try context.fetch(GameScore.fetchRequest()) as? [GameScore] else { return [] }
            return gameScores
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func getScores() -> [Score] {
        var scores: [Score] = []
        let fetchResults = fetchGameScores()
        for result in fetchResults {
            let score = Score(total: result.total, first: result.first, second: result.second, wrong: result.wrong)
            scores.append(score)
        }
        return scores
    }
}
