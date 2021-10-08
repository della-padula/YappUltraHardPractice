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
    
    private var folder: Folder = Folder(url: nil, name: "폴더 0",
                                        folders: [Folder(url: nil, name: "폴더 1", folders: [], pictures: []),
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
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc
    private func addButtonTapped() {
        self.present(imagePicker, animated: true)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DataCell.self, forCellWithReuseIdentifier: DataCell.identifier)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(92)
            $0.bottom.left.right.equalToSuperview().inset(16)
        }
    }
}

extension MainViewController:  UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    private func setupImagePicker() {
        imagePicker.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let imageUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }

        let newPicture = Picture(url: imageUrl, name: "사진")
        folder.pictures.append(newPicture)
        
        picker.dismiss(animated: true, completion: nil)
        
        collectionView.reloadData()
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
        let width = (collectionView.frame.width - 8 * 2) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < folder.folders.count {
            let folderVC = FolderViewController()
            folderVC.folder = folder.folders[indexPath.row]
            self.navigationController?.pushViewController(folderVC, animated: true)
        } else {
            print("\(folder.name)에서 \(folder.pictures[indexPath.row - folder.folders.count].name)이 클릭됨")
        }
    }
}
