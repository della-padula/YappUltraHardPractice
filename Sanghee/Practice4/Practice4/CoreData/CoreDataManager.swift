//
//  CoreDataManager.swift
//  Practice4
//
//  Created by leeesangheee on 2021/10/09.
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
    
    var folderEntity: NSEntityDescription? {
        return  NSEntityDescription.entity(forEntityName: "FolderEntity", in: context)
    }
    var pictureEntity: NSEntityDescription? {
        return  NSEntityDescription.entity(forEntityName: "PictureEntity", in: context)
    }
    
    func saveToContext() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
