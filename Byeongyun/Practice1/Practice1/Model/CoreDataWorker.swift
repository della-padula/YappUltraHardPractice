//
//  CoreDataWorker.swift
//  Practice1
//  CoreData 정의 파일
//  Created by ITlearning on 2021/09/24.
//

import UIKit
import CoreData

class CoreDataWorker {
    static var shared: CoreDataWorker = CoreDataWorker()
    
    // NSPerisistenContainer : Core Data Stack을 나타내는 필요한 모든 객체를 포함한다.
    // 따라서 Core Data Stack을 사용하기 위해 이렇게 Model로 지어진 Entity를 불러온 것이다.
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
    
    // 지정해놓은 Core Data에서 NSManagedObjectContext를 가져온다.
    // NSManagedObjectContext : managed object를 생성하고, 저장하고, 가져오는 작업을 제공한다.
    var feedContext: NSManagedObjectContext {
        // viewContext : Main Queue의 Managed object context이다.
        // feedArrayContainer가 Core Data Stack를 나타내는 모든 객체를 포함한다고 했으니,
        // 당연히 NSMangedObjecContext 도 존재한다. 따라서
        // NSMangedObjecContext를 가져온다.
        return feedArrayContainer.viewContext
    }
    
    func saveFeed() {
        // hasChanges : 해당 Context가 바뀌었는지 체크
        if feedContext.hasChanges {
            // perform : ContextQueue에서 지정된 블록을 비동기적으로 수행한다.
            feedContext.perform {
                do {
                    // save : 저장되지 않은 변경 사항을 등록된 개체에 대해 Context의 저장소에 저장한다.
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
            // validateForInsert : managed object를 현재 상태로 append할 수 있는지 여부를 결정한다.
            try feedArray.validateForInsert()
        // 에러 발생시
        } catch let error as NSError {
            // rollback : 모든 항목을 제거하고 모든 append 및 delete를 취소하고 업데이트 된 오브젝트 또한 마지막으로 올려진 값으로 복원한다.
            feedArray.managedObjectContext?.rollback()
            completion?(error)
            return
        }
        
        // 그게 아니면 저장하는 방법을 택한다.
        saveFeed()
        completion?(nil)
        
    }
    
    func read() -> [FeedArray] {
        // NSFetchRequest : persistent store 에서 데이터를 검색하는 데 사용되는 검색 기준에 대한 정의가 담겨있는 클래스이다.
        // fetchRequest : 비동기적으로 실행되는 기본적인 가져오기 요청이다.
        let readRequest: NSFetchRequest<FeedArray> = FeedArray.fetchRequest()
        
        var feedList = [FeedArray]()
        
        // Sorting Function
        // NSSortDescriptor : 모든 오브젝트에 공통으로 적용되는 컬렉션을 적용하는 방법에 대한 클래스.
        // 특히 Sorting 과 관련된 기능들이 정의 되어있다.
        let sort = NSSortDescriptor(key: #keyPath(FeedArray.time), ascending: false)
        readRequest.sortDescriptors = [sort]
        // 블록 안의 작업이 Context에 대한 올바른 대기열에서 실행되는지 확인한다.
        feedContext.performAndWait {
            do {
                // fetch : 위에서 정렬된 Entity를 기준으로 지정된 항목의 배열을 반환한다.
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
        // delete : 변경사항을 저장할 때 영구 저장소에서 제거해야 하는 오브젝트를 지정한다.
        feedContext.delete(feedArray)
        saveFeed()
    }
}
