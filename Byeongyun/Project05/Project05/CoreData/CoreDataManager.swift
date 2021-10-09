//
//  CoreDataManager.swift
//  Project05
//
//  Created by ITlearning on 2021/10/09.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var dataContextContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler:  {
            data, error in
            if let error = error as NSError? {
                fatalError("Error")
            }
        })
        return container
    }()
    
    var dataContext: NSManagedObjectContext {
        return dataContextContainer.viewContext
    }
    
    func saveData() {
        do {
            try self.dataContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func fetchFolder() -> [CData] {
        do {
            let request: NSFetchRequest<CData> = CData.fetchRequest()
            let result = try dataContext.fetch(request)
            return result
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func crateFolder(_ folder: Folder) {
        guard let dataEntity = NSEntityDescription.entity(forEntityName: "CData", in: dataContext) else { return }
        let user = NSManagedObject(entity: dataEntity, insertInto: dataContext)
        user.setValue(folder.id, forKey: "id")
        user.setValue(folder.index, forKey: "index")
        user.setValue(folder.parentId, forKey: "parentId")
        user.setValue(folder.name, forKey: "name")
        user.setValue(folder.photo, forKey: "photo")
        
        saveData()
    }
    
    func getCount() -> Int {
        let fetchResult = fetchFolder()
        return fetchResult.count
    }
    
    func getFolder(_ parentId: Int) -> [Folder] {
        var folders: [Folder] = []
        let fetchResult = fetchFolder()
        for result in fetchResult {
            let id: Int = Int(result.id)
            if parentId == result.parentId {
                let folder = Folder(index: result.index ?? UUID() , id: id, parentId: parentId, name: result.name ?? "", photo: result.photo ?? nil)
                folders.append(folder)
            }
        }
        
        return folders
    }
    
    func updateFolder(_ folder: Folder, name: String) {
        let fetchResult = fetchFolder()
        for result in fetchResult {
            if result.index == folder.index {
                result.name = name
            }
        }
        saveData()
    }
    
    func deleteFolder(_ index: UUID) {
        let deleteFolder = fetchFolder().filter({ $0.index == index })[0]
        dataContext.delete(deleteFolder)
        saveData()
    }
}
