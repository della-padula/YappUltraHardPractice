//
//  PersistenceManager.swift
//  Practice1
//
//  Created by leeesangheee on 2021/09/24.
//

import CoreData
import Foundation

class PersistenceManager {
    static var shared: PersistenceManager = PersistenceManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var bookmarkEntity: NSEntityDescription? {
        return  NSEntityDescription.entity(forEntityName: "Bookmark", in: context)
    }
    
    func saveToContext() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func insertBookmark(_ notice: Notice) {
        if let entity = bookmarkEntity {
            let managedObject = NSManagedObject(entity: entity, insertInto: context)
            managedObject.setValue(notice.url, forKey: "notice")
            saveToContext()
        }
    }
    
    func fetchBookmark() -> [Bookmark] {
        do {
            let request = Bookmark.fetchRequest()
            let data = try context.fetch(request)
            print(data)
            return data
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func deleteBookmark() {
        let fetchResult = fetchBookmark()
        if let bookmark = fetchResult.last {
            context.delete(bookmark)
        }
        saveToContext()
    }
}

