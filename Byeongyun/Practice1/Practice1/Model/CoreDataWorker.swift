//
//  CoreDataWorker.swift
//  Practice1
//
//  Created by ITlearning on 2021/09/24.
//

import UIKit
import CoreData

class CoreDataWorker {
    static var shared: CoreDataWorker = CoreDataWorker()
    
    lazy var feedArrayContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: {
            (data, error) in
            if let error = error as NSError? {
                fatalError("Error")
            }
        })
        return container
    }()
    
    var feedContext: NSManagedObjectContext {
        return feedArrayContainer.viewContext
    }
    
    func saveFeed() {
        if feedContext.hasChanges {
            feedContext.perform {
                do {
                    try self.feedContext.save()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
    
    func insert(userImage: Data, userName: String, text: String, like: Int, uploadImage: Data, time: Date, completion: ((_ error: NSError?) -> Void)? = nil) {
        let feedArray = FeedArray(context: feedContext)
        
        feedArray.userImage = userImage
        feedArray.userName = userName
        feedArray.text = text
        feedArray.like = Int16(like)
        feedArray.uploadImage = uploadImage
        feedArray.time = time
        
        do {
            try feedArray.validateForInsert()
        } catch let error as NSError {
            feedArray.managedObjectContext?.rollback()
            completion?(error)
            return
        }
        
        saveFeed()
        completion?(nil)
        
    }
    
    func read() -> [FeedArray] {
        let readRequest: NSFetchRequest<FeedArray> = FeedArray.fetchRequest()
        
        var feedList = [FeedArray]()
        let sort = NSSortDescriptor(key: #keyPath(FeedArray.time), ascending: false)
        readRequest.sortDescriptors = [sort]
        feedContext.performAndWait {
            do {
                feedList = try feedContext.fetch(readRequest)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        
        return feedList
    }
    
    func update(_ feedArray: FeedArray, userImage: Data, userName: String, text: String, like: Int, uploadImage: Data, time: Date, completion: (() -> Void)? = nil) {
        feedArray.userImage = userImage
        feedArray.userName = userName
        feedArray.text = text
        feedArray.like = Int16(like)
        feedArray.uploadImage = uploadImage
        feedArray.time = time
        
        saveFeed()
        completion?()
    }
    
    func delete(_ feedArray: FeedArray) {
        feedContext.delete(feedArray)
        saveFeed()
    }
}
