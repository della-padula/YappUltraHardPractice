//
//  InsideViewController.swift
//  Project4
//
//  Created by 박지윤 on 2021/10/09.
//

import Foundation
import UIKit
class FolderViewController:  UIViewController{
    let folder: Folder
    var deleteButton = UIBarButtonItem()
    var addButton = UIBarButtonItem()
    var indexPath = IndexPath()
    var id: Int64 = 0
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
    }
    init(_ folder: Folder, _ indexPath: IndexPath) {
        self.folder = folder
        self.indexPath = indexPath
        super.init(nibName: nil, bundle: nil)
        setButton()
        navigationItem.rightBarButtonItems = [addButton, deleteButton]
        navigationItem.title = folder.folderName
        manageFilePath()
    }
    
    func setButton() {
        deleteButton = {
            let button = UIBarButtonItem(image: UIImage(systemName: "folder.badge.minus")?.withTintColor(.blue), style: .done, target: self, action: #selector(deleteData))
            return button
        }()
        
        addButton = {
            let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonPressed(_ :)))
            return button
        }()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func openImagePicker() {
        let photoVC = PhotoViewController()
        present(photoVC, animated: true, completion: nil)
    }
    func manageFilePath() -> String {
        let fileManager = FileManager.default
        let currentPath = fileManager.currentDirectoryPath
        print("#####",currentPath)
        fileManager.changeCurrentDirectoryPath(currentPath)
        return currentPath
    }
    @objc
    func deleteData(_ sender: Any?) {
        CoreDataManager.shared.deleteFolder(indexPath: indexPath)
        dismiss(animated: true, completion: nil)
    }
    @objc
    func plusButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "어떤 것을 추가하시겠습니까?", message: "추가할 파일/폴더의 종류를 선택해주세요.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "사진", style: .default, handler: { _ in
            self.openImagePicker()
        }))
        
        alert.addAction(UIAlertAction(title: "폴더", style: .default, handler: { _ in
            var newFolderName = ""
            let titleAlert = UIAlertController(title: "폴더 생성", message: "생성할 폴더 이름을 작성해 주세요", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default) { ok in
                newFolderName = (titleAlert.textFields?[0].text)!
                
                let newFolder = Folder(context: CoreDataManager.context)
                newFolder.id = self.id
                newFolder.folderName = newFolderName
                newFolder.folderLocation = self.manageFilePath()
                CoreDataManager.shared.saveFolders()
                CoreDataManager.folderArray.append(newFolder)

            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { cancel in
            }
            titleAlert.addTextField()
            titleAlert.addAction(ok)
            titleAlert.addAction(cancel)
            self.present(titleAlert, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { (_) in
        }))
        
        self.present(alert, animated: true) {
        }
    }
}
