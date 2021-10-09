//
//  Folder.swift
//  Project4
//
//  Created by 박지윤 on 2021/10/09.
//

import CoreData
import Foundation
import UIKit

class CoreDataManager {
    static var folderArray: [Folder] = []
    static var photoArray: [Photo] = []
    static let context = AppDelegate().persistentContainer.viewContext
    static var shared: CoreDataManager = CoreDataManager()

    func fetch() -> [Folder]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return [] }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Folder")
        do {
            let result = try managedContext.fetch(fetchRequest) as! [Folder]
            return result
        } catch {
            print(error.localizedDescription)
        }
        print("error")
        return nil
    }
    
    func insertFolder(_ data: Folder) {
        let request: NSFetchRequest<Folder> = Folder.fetchRequest()
        do {
            CoreDataManager.folderArray = try CoreDataManager.context.fetch(request)
        } catch {
            print("Error fetching data, \(error.localizedDescription)")
        }
    }
    
    func saveFolders() {
        do {
            try CoreDataManager.context.save()
        } catch {
            print("Error saving context, \(error.localizedDescription)")
        }
    }
    
    func deleteFolder(indexPath: IndexPath) {
        print(indexPath.row)
        print(CoreDataManager.folderArray)
        CoreDataManager.context.delete(CoreDataManager.folderArray[indexPath.row])
        CoreDataManager.folderArray.remove(at: indexPath.row)
        saveFolders()
    }
    
    func getFolderCount() -> Int {
        let request: NSFetchRequest<Folder> = Folder.fetchRequest()
        do {
            let count = try CoreDataManager.context.count(for: request)
            return count
        } catch {
            print(error.localizedDescription)
            return 0
        }
    }
    
    func fetchPhoto() -> [Photo]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return [] }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        do {
            let result = try managedContext.fetch(fetchRequest) as! [Photo]
            return result
            
        } catch {
            print(error.localizedDescription)
        }
        print("error")
        return nil
    }
    
    func getPhotoCount() -> Int {
        let request: NSFetchRequest<Photo> = Photo.fetchRequest()
        do {
            let count = try CoreDataManager.context.count(for: request)
            return count
        } catch {
            print(error.localizedDescription)
            return 0
        }
    }
}

