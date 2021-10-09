//
//  MainViewController.swift
//  Practice4
//
//  Created by leeesangheee on 2021/10/08.
//

import SnapKit
import UIKit

class MainViewController: UIViewController {
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
    
    private var column: CGFloat = 2
    private var folder: Folder = Folder(path: "", name: "폴더 0",
                                        folders: [Folder(path: "", name: "폴더 1", folders: [], pictures: []),
                                        ],
                                        pictures: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBar()
        setupImagePicker()
        setupCollectionView()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "사진 탐색기"
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAlert))
        let columnButton = UIBarButtonItem(image: UIImage(systemName: column == 1 ? "square" : column == 2 ? "square.grid.2x2" : "square.grid.3x3"), style: .plain, target: self, action: #selector(columnButtonTapped))
        
        navigationItem.rightBarButtonItems = [addButton, columnButton]
    }
    
    @objc
    private func showAlert() {
        let alert = UIAlertController(title: "폴더 및 사진 추가", message: "무엇을 추가하시겠습니까?", preferredStyle: .actionSheet)
        let folderAction = UIAlertAction(title: "폴더 생성", style: .default) { _ in
            let newFolder = Folder(path: "", name: "새 폴더", folders: [], pictures: [])
            self.folder.folders.append(newFolder)
            
            self.collectionView.reloadData()
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
    
    @objc
    private func columnButtonTapped() {
        column = column == 1 ? 2 : column == 2 ? 3 : 1
        setupNavigationBar()
        collectionView.reloadData()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DataCell.self, forCellWithReuseIdentifier: DataCell.identifier)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(92)
            $0.bottom.left.right.equalToSuperview().inset(8)
        }
    }
}

extension MainViewController:  UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    private func setupImagePicker() {
        imagePicker.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let imageUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }

        let newPicture = Picture(url: imageUrl, path: "", name: "사진")
        folder.pictures.append(newPicture)
        collectionView.reloadData()
        
        picker.dismiss(animated: true, completion: nil)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return folder.folders.count + folder.pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DataCell.identifier, for: indexPath) as! DataCell
        
        if indexPath.row < folder.folders.count {
            cell.folder = folder.folders[indexPath.row]
        } else {
            cell.picture = folder.pictures[indexPath.row - folder.folders.count]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 8 * (column - 1)) / column
        return CGSize(width: width, height: width + 22)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < folder.folders.count {
            let folderVC = FolderViewController(folder.folders[indexPath.row])
            self.navigationController?.pushViewController(folderVC, animated: true)
        } else {
            let pictureVC = PictureViewController(folder.pictures[indexPath.row - folder.folders.count])
            pictureVC.modalPresentationStyle = .overCurrentContext
            self.present(pictureVC, animated: true, completion: nil)
        }
    }
}
