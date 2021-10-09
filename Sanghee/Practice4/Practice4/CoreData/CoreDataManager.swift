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
        managedObject.setValue(picture.path, forKey: "path")
        managedObject.setValue(picture.url, forKey: "url")
        managedObject.setValue(picture.name, forKey: "name")
        saveToContext()
    }
    
    func readFolders() -> [Folder] {
        var folders: [Folder] = []
        let fetchResult = fetchFolders()
        for result in fetchResult {
            guard let id = result.id, let path = result.path, let name = result.name else { continue }
            let folder = Folder(id: id, path: path, name: name, folders: [], pictures: [])
            folders.append(folder)
        }
        
        return folders
    }
    func readPictures() -> [Picture] {
        var pictures: [Picture] = []
        let fetchResult = fetchPictures()
        for result in fetchResult {
            guard let id = result.id, let url = result.url, let path = result.path, let name = result.name else { continue }
            let picture = Picture(id: id, path: path, url: url, name: name)
            pictures.append(picture)
        }
        return pictures
    }
    
    func updateFolder(_ folder: Folder, newName: String) {
        let fetchResult = fetchFolders()
        for result in fetchResult {
            if result.id == folder.id {
                result.name = newName
                break
            }
        }
        saveToContext()
    }
    func updatePicture(_ picture: Picture, newName: String) {
        let fetchResult = fetchPictures()
        for result in fetchResult {
            if result.id == picture.id {
                result.name = picture.name
                break
            }
        }
        saveToContext()
    }
    
    func deleteFolder(_ folder: Folder) {
        let fetchResult = fetchFolders()
        let folder = fetchResult.filter({ $0.id == folder.id })[0]
        context.delete(folder)
        saveToContext()
    }
    func deletePicture(_ picture: Picture) {
        let fetchResult = fetchPictures()
        let picture = fetchResult.filter({ $0.id == picture.id })[0]
        context.delete(picture)
        saveToContext()
    }
}
