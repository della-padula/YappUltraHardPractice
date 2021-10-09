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
    
    private var column: CGFloat = 2
    private var folder: Folder
    
    init(_ folder: Folder) {
        self.folder = folder
        super.init(nibName: nil, bundle: nil)
        print(folder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBar()
        setupImagePicker()
        setupCollectionView()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = folder.name
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        let columnButton = UIBarButtonItem(image: UIImage(systemName: column == 1 ? "square" : column == 2 ? "square.grid.2x2" : "square.grid.3x3"), style: .plain, target: self, action: #selector(columnButtonTapped))
        
        navigationItem.rightBarButtonItems = [addButton, columnButton]
    }
    
    @objc
    private func addButtonTapped() {
        self.present(imagePicker, animated: true)
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

extension FolderViewController:  UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    private func setupImagePicker() {
        imagePicker.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let imageUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }

        let newPicture = Picture(id: UUID(), path: "", url: imageUrl, name: "사진")
        folder.pictures.append(newPicture)
        collectionView.reloadData()
        
        picker.dismiss(animated: true, completion: nil)
    }
}

extension FolderViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, UICollectionViewDataSource {
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
