//
//  CoreDataManager.swift
//  Practice1
//
//  Created by leeesangheee on 2021/09/24.
//

import CoreData
import Foundation

class CoreDataManager {
    static var shared: CoreDataManager = CoreDataManager()
    
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
    
    func fetchBookmarks() -> [Bookmark] {
        do {
            let request = Bookmark.fetchRequest()
            let results = try context.fetch(request)
            return results
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func insertBookmark(_ notice: Notice) {
        if let entity = bookmarkEntity {
            let managedObject = NSManagedObject(entity: entity, insertInto: context)
            managedObject.setValue(notice.title, forKey: "title")
            managedObject.setValue(notice.time, forKey: "time")
            managedObject.setValue(notice.url, forKey: "url")
            saveToContext()
        }
    }
    
    func getBookmarks() -> [Notice] {
        var notices: [Notice] = []
        let fetchResults = fetchBookmarks()
        for result in fetchResults {
            let notice = Notice(title: result.title ?? "", time: result.time ?? "", url: result.url ?? "")
            notices.append(notice)
        }
        return notices
    }
    
    func deleteBookmark(_ notice: Notice) {
        let fetchResults = fetchBookmarks()
        let notice = fetchResults.filter({ $0.url == notice.url })[0]
        context.delete(notice)
        saveToContext()
    }
}

