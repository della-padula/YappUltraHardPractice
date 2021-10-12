//
//  FolderViewController.swift
//  Practice4
//
//  Created by leeesangheee on 2021/10/08.
//

import SnapKit
import UIKit

class FolderViewController: UIViewController {
    private let imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        return imagePicker
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private let manager = CoreDataManager.shared
    private var parentFolder = Folder(id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!, path: "root", name: "사진 탐색기")
    private var folders: [Folder] = []
    private var pictures: [Picture] = []
    private var imagePickerUrl: URL?

    private var column: CGFloat = 2
    private var topBottomPadding: CGFloat = 0
    private var leftRightPadding: CGFloat = 8
    private var extraHeightPadding: CGFloat = 32
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        getData()
        
        setupNavigationBar()
        setupImagePicker()
        setupCollectionView()
        setupLongPressGesture()
    }
    
    private func getData() {
        folders = manager.getFolders(parentFolder.path)
        pictures = manager.getPictures(folderId: parentFolder.id, path: parentFolder.path)
    }
    
    private func reloadCollection() {
        collectionView.reloadData()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = parentFolder.name
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showCreateAlert))
        let columnButton = UIBarButtonItem(image: UIImage(systemName: column == 4 ? "square.grid.4x3.fill" : column == 2 ? "square.grid.2x2" : "square.grid.3x3"), style: .plain, target: self, action: #selector(columnButtonTapped))
        
        navigationItem.rightBarButtonItems = [addButton, columnButton]
    }
    
    @objc
    private func showCreateAlert() {
        let alert = UIAlertController(title: "폴더 및 사진 추가", message: "무엇을 추가하시겠습니까?", preferredStyle: .alert)
        let folderAction = UIAlertAction(title: "폴더 생성", style: .default) { _ in
            self.showFolderNameAlert()
        }
        let pictureAction = UIAlertAction(title: "사진 추가", style: .default) { _ in
            self.present(self.imagePicker, animated: true)
        }
        let noAction = UIAlertAction(title: "취소", style: .destructive)
        
        alert.addAction(folderAction)
        alert.addAction(pictureAction)
        alert.addAction(noAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func showFolderNameAlert() {
        let alert = UIAlertController(title: "새로운 폴더", message: "폴더 이름을 입력하세요", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            guard let name = alert.textFields?[0].text else { return }
            
            let newFolder = Folder(id: UUID(), path: "\(self.parentFolder.path)/\(name)", name: name)
            
            self.folders.append(newFolder)
            self.reloadCollection()
            self.manager.createFolder(newFolder)
        }
        let noAction = UIAlertAction(title: "취소", style: .destructive)

        alert.addAction(noAction)
        alert.addAction(okAction)
        alert.addTextField { textField in
            textField.placeholder = "폴더 이름"
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    private func showPictureNameAlert() {
        let alert = UIAlertController(title: "새로운 사진", message: "사진 이름을 입력하세요", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            guard let name = alert.textFields?[0].text, name.trimmingCharacters(in: .whitespaces).count > 0, let url = self.imagePickerUrl else { return }
            
            let newPicture = Picture(id: UUID(), folderId: self.parentFolder.id, path: "\(self.parentFolder.path)/\(name)", url: url, name: name)
            
            self.pictures.append(newPicture)
            self.reloadCollection()
            self.manager.createPicture(newPicture)
        }
        let noAction = UIAlertAction(title: "취소", style: .destructive)

        alert.addAction(noAction)
        alert.addAction(okAction)
        alert.addTextField { textField in
            textField.placeholder = "사진 이름"
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc
    private func columnButtonTapped() {
        column = column == 2 ? 3 : column == 3 ? 4 : 2
        setupNavigationBar()
        reloadCollection()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DataCell.self, forCellWithReuseIdentifier: DataCell.identifier)
    
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(92)
            $0.left.right.equalToSuperview().inset(leftRightPadding)
        }
    }
 
    @objc
    private func longPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let point = sender.location(in: collectionView)
            if let indexPath = collectionView.indexPathForItem(at: point) {
                let isFolder = (indexPath.section == Section.folder.rawValue)
                showEditAlert(index: indexPath.row, isFolder: isFolder)
            }
        }
    }
    
    private func showEditAlert(index: Int, isFolder: Bool) {
        let itemName = isFolder ? "폴더" : "사진"
        let itemPath = "\(self.parentFolder.path)/\(isFolder ? self.folders[index].name : self.pictures[index].name)"
        
        let alert = UIAlertController(title: "\(itemName) 편집", message: "\(itemName)를 편집하시겠습니까?", preferredStyle: .alert)
        let editAction = UIAlertAction(title: "수정", style: .default) { _ in
            guard let name = alert.textFields?[0].text, name.trimmingCharacters(in: .whitespaces).count > 0 else { return }
            
            if isFolder {
                self.folders[index].name = name
                self.folders[index].path = "\(self.parentFolder.path)/\(name)"
                self.manager.updateFolder(itemPath, newName: name)
            } else {
                self.pictures[index].name = name
                self.pictures[index].path = "\(self.parentFolder.path)/\(name)"
                self.manager.updatePicture(itemPath, newName: name)
            }
            
            self.reloadCollection()
        }
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
            if isFolder {
                self.folders.remove(at: index)
                self.manager.deleteFolder(itemPath)
            } else {
                self.pictures.remove(at: index)
                self.manager.deletePicture(itemPath)
            }
            
            self.reloadCollection()
        }
        
        alert.addAction(deleteAction)
        alert.addAction(editAction)
        alert.addTextField { textField in
            textField.placeholder = "\(itemName) 이름"
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    private func setupLongPressGesture() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        collectionView.addGestureRecognizer(longPress)
    }
}

extension FolderViewController:  UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    private func setupImagePicker() {
        imagePicker.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let imageUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
        imagePickerUrl = imageUrl
        
        picker.dismiss(animated: true) {
            self.showPictureNameAlert()
        }
    }
}

extension FolderViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case Section.folder.rawValue: return folders.count
        case Section.picture.rawValue: return pictures.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DataCell.identifier, for: indexPath) as! DataCell
        
        switch indexPath.section {
        case Section.folder.rawValue: cell.folder = folders[indexPath.row]
        case Section.picture.rawValue: cell.picture = pictures[indexPath.row]
        default: break
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - leftRightPadding * (column - 1)) / column
        
        return CGSize(width: width, height: width + extraHeightPadding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return topBottomPadding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return leftRightPadding
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == Section.folder.rawValue {
            let folder = folders[indexPath.row]
            let parentFolder = Folder(id: folder.id, path: "\(folder.path)/\(folder.name)", name: folder.name)

            let mainVC = FolderViewController()
            mainVC.parentFolder = parentFolder
            
            self.navigationController?.pushViewController(mainVC, animated: true)
        } else if indexPath.section == Section.picture.rawValue {
            let pictureVC = PictureViewController(pictures[indexPath.row])
            pictureVC.modalPresentationStyle = .overCurrentContext
            
            self.present(pictureVC, animated: true, completion: nil)
        }
    }
}
