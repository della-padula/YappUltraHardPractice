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
    
    func fetchFolders() -> [FolderEntity] {
        do {
            let request: NSFetchRequest<FolderEntity> = FolderEntity.fetchRequest()
            let result = try context.fetch(request)
            return result
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func fetchPictures() -> [PictureEntity] {
        do {
            let request: NSFetchRequest<PictureEntity> = PictureEntity.fetchRequest()
            let result = try context.fetch(request)
            
            return result
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func createFolder(_ folder: Folder) {
        guard let entity = folderEntity else { return }
        
        let managedObject = NSManagedObject(entity: entity, insertInto: context)
        managedObject.setValue(folder.id, forKey: "id")
        managedObject.setValue(folder.path, forKey: "path")
        managedObject.setValue(folder.name, forKey: "name")
        
        saveToContext()
    }
    
    func createPicture(_ picture: Picture) {
        guard let entity = pictureEntity else { return }
        
        let managedObject = NSManagedObject(entity: entity, insertInto: context)
        managedObject.setValue(picture.id, forKey: "id")
        managedObject.setValue(picture.folderId, forKey: "folderId")
        managedObject.setValue(picture.path, forKey: "path")
        managedObject.setValue(picture.url, forKey: "url")
        managedObject.setValue(picture.name, forKey: "name")
        
        saveToContext()
    }
    
    func isSamePath(path: String, itemPath: String) -> Bool {
        let hasPath = itemPath.hasPrefix(path)
        let isSubPath = (path.filter({ $0 == "/" }).count + 1) == itemPath.filter({ $0 == "/" }).count
        
        return hasPath && isSubPath
    }
    
    func getFolders(_ path: String) -> [Folder] {
        var folders: [Folder] = []
        let fetchResult = fetchFolders()
        
        for result in fetchResult {
            guard let id = result.id, let itemPath = result.path, let name = result.name else { continue }
            let isSamePath = isSamePath(path: path, itemPath: itemPath)
            
            if isSamePath && path != itemPath {
                let folder = Folder(id: id, path: path, name: name)
                folders.append(folder)
            }
        }
        
        return folders
    }
    
    func getPictures(folderId: UUID, path: String) -> [Picture] {
        var pictures: [Picture] = []
        let fetchResult = fetchPictures()
        
        for result in fetchResult {
            guard let id = result.id, let itemFolderId = result.folderId, let url = result.url, let itemPath = result.path, let name = result.name else { continue }
            let isSamePath = isSamePath(path: path, itemPath: itemPath)
            
            if isSamePath && itemFolderId == folderId {
                let picture = Picture(id: id, folderId: id, path: path, url: url, name: name)
                pictures.append(picture)
            }
        }
        
        return pictures
    }
    
    func updateFolder(_ path: String, newName: String) {
        let fetchResult = fetchFolders()
        
        for result in fetchResult {
            if result.path == path {
                var newPath = path.split(separator: "/")
                newPath.removeLast()
                let folderPath = newPath.map({ $0 + "/" }).reduce("", +) + "\(newName)"
                result.name = newName
                result.path = folderPath
            }
        }
        
        saveToContext()
    }
    
    func updatePicture(_ path: String, newName: String) {
        let fetchResult = fetchPictures()
        
        for result in fetchResult {
            if result.path == path {
                var newPath = path.split(separator: "/")
                newPath.removeLast()
                let picturePath = newPath.map({ $0 + "/" }).reduce("", +) + "\(newName)"
                result.name = newName
                result.path = picturePath
            }
        }
        
        saveToContext()
    }
    
    func deleteFolder(_ path: String) {
        let folderResult = fetchFolders()
        let pictureResult = fetchPictures()
        
        for result in folderResult {
            guard let resultPath = result.path else { continue }
            if resultPath.hasPrefix(path) {
                context.delete(result)
            }
        }
        
        for result in pictureResult {
            guard let resultPath = result.path else { continue }
            if resultPath.hasPrefix(path) {
                context.delete(result)
            }
        }

        saveToContext()
    }
    
    func deletePicture(_ path: String) {
        let fetchResult = fetchPictures()
        
        for result in fetchResult {
            if result.path == path {
                context.delete(result)
                break
            }
        }
        
        saveToContext()
    }
    
    func resetAll() {
        resetAllFolders()
        resetAllPictures()
    }
    
    func resetAllFolders() {
        let fetchResult = fetchFolders()
        
        fetchResult.forEach({
            context.delete($0)
        })
        
        saveToContext()
    }
    
    func resetAllPictures() {
        let fetchResult = fetchPictures()
        
        fetchResult.forEach({
            context.delete($0)
        })
        
        saveToContext()
    }
}
