//
//  FolderView.swift
//  Project4
//
//  Created by 박지윤 on 2021/10/09.
//

import Foundation
import UIKit

class FolderView: UIViewController {
    var rightButton = UIBarButtonItem()
    let button = UIButton()
    var deleteButton = UIBarButtonItem()
    var addButton = UIBarButtonItem()
    let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: UICollectionViewFlowLayout.init())
    let sectionInset = UIEdgeInsets(top: 20, left: 30, bottom: 20, right: 30)
    var id: Int64 = 0
    var currentPath: String = ""
    var indexPath = IndexPath()
    
    let folderModel = CoreDataManager.shared.fetch()
    let photoModel = CoreDataManager.shared.fetchPhoto()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        currentPath = manageFilePath()
    }
    init(_ folder: Folder, path: String) {
        super.init(nibName: nil, bundle: nil)
        view.addSubview(collectionView)
        navigationItem.rightBarButtonItem = rightButton
        navigationItem.title = folder.folderName
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setView() {
        setNavigationItems()
        setCollectionView()
        setButton()
    }
    
    func setCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2) * 0.7, height: (UIScreen.main.bounds.width / 2) * 0.7)
        flowLayout.minimumInteritemSpacing = 5
        collectionView.collectionViewLayout = flowLayout
        collectionView.register(CollectionFolderCell.self, forCellWithReuseIdentifier: CollectionFolderCell.identifier)
        collectionView.register(CollectionPhotoCell.self, forCellWithReuseIdentifier: CollectionPhotoCell.identifier)
        
        collectionView.snp.makeConstraints { maker in
            maker.top.equalToSuperview()
            maker.centerX.equalToSuperview()
            maker.height.equalToSuperview()
            maker.width.equalToSuperview()
        }
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
    
    func setNavigationItems() {
        rightButton = {
            let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonPressed(_ :)))
            button.tag = 1
            return button
        }()
        navigationItem.rightBarButtonItem = rightButton
        navigationItem.title = "My Drive"
    }
    
    func manageFilePath() -> String {
        let fileManager = FileManager.default
        let currentPath = fileManager.currentDirectoryPath
        fileManager.changeCurrentDirectoryPath(currentPath)
        return currentPath
    }
    
    func openImagePicker() {
        let photoVC = PhotoViewController()
        present(photoVC, animated: true, completion: nil)
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
            let ok = UIAlertAction(title: "OK", style: .default) { [self] ok in
                newFolderName = (titleAlert.textFields?[0].text)!
                
                let newFolder = Folder(context: CoreDataManager.context)
                newFolder.id = self.id
                newFolder.folderName = newFolderName
                
                let newPath = "\(currentPath)\(newFolderName)"
                newFolder.folderLocation = newPath
                CoreDataManager.shared.saveFolders()
                CoreDataManager.folderArray.append(newFolder)
                
                self.collectionView.reloadData()
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
    @objc
    func deleteData(_ sender: Any?) {
        CoreDataManager.shared.deleteFolder(indexPath: indexPath)
        dismiss(animated: true, completion: nil)
    }
}

extension FolderView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let folderWithPath = CoreDataManager.shared.fetchWithPath(path: currentPath)
        print(folderWithPath)
        return CoreDataManager.shared.getFolderCount() + CoreDataManager.shared.getPhotoCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < CoreDataManager.shared.getFolderCount() {
            let folderName = folderModel![indexPath.row].folderName
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionFolderCell.identifier, for: indexPath) as! CollectionFolderCell
            cell.titleLabel.text = folderName ?? "nil"
            collectionView.addSubview(cell)

            return cell
        } else {
            let photo = UIImage(data: photoModel![indexPath.row - CoreDataManager.shared.getFolderCount()].image!)
            let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionPhotoCell.identifier, for: indexPath) as! CollectionPhotoCell
            photoCell.image = photo!
            collectionView.addSubview(photoCell)
            
            return photoCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let folderVC = FolderView(folderModel![indexPath.row], path: currentPath)
        navigationController?.pushViewController(folderVC, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInset
    }
}
