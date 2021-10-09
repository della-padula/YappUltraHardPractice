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
    
    private let folderCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    private let pictureCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private var imagePickerUrl: URL?
    private var folder: Folder = Folder(id: UUID(), path: "", name: "폴더 0",
                                        folders: [Folder(id: UUID(), path: "", name: "폴더 1", folders: [], pictures: []),
                                        ],
                                        pictures: [])
    
    private var column: CGFloat = 2
    private var topBottomPadding: CGFloat = 12
    private var leftRightPadding: CGFloat = 8
    private var extraHeightPadding: CGFloat = 22
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBar()
        setupImagePicker()
        setupCollectionView()
    }
    
    private func reloadCollectionViewData() {
        updateFolderCollectionViewHeight()
        
        folderCollectionView.reloadData()
        pictureCollectionView.reloadData()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "사진 탐색기"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAlert))
        let columnButton = UIBarButtonItem(image: UIImage(systemName: column == 1 ? "square" : column == 2 ? "square.grid.2x2" : "square.grid.3x3"), style: .plain, target: self, action: #selector(columnButtonTapped))
        
        navigationItem.rightBarButtonItems = [addButton, columnButton]
    }
    
    @objc
    private func showAlert() {
        let alert = UIAlertController(title: "폴더 및 사진 추가", message: "무엇을 추가하시겠습니까?", preferredStyle: .alert)
        let folderAction = UIAlertAction(title: "폴더 생성", style: .default) { _ in
            self.showFolderNameAlert()
        }
        let pictureAction = UIAlertAction(title: "사진 추가", style: .default) { _ in
            self.present(self.imagePicker, animated: true)
        }
        let noAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(folderAction)
        alert.addAction(pictureAction)
        alert.addAction(noAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func showFolderNameAlert() {
        let alert = UIAlertController(title: "새로운 폴더", message: "폴더 이름을 입력하세요", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .destructive) { _ in
            guard let name = alert.textFields?[0].text else { return }
            let newFolder = Folder(id: UUID(), path: "", name: name, folders: [], pictures: [])
            self.folder.folders.append(newFolder)
            self.reloadCollectionViewData()
        }
        let noAction = UIAlertAction(title: "취소", style: .cancel)

        alert.addAction(okAction)
        alert.addAction(noAction)
        alert.addTextField { textField in
            textField.placeholder = "폴더 이름"
        }
        
        present(alert, animated: true, completion: nil)
    }
    private func showPictureNameAlert() {
        let alert = UIAlertController(title: "새로운 사진", message: "사진 이름을 입력하세요", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .destructive) { _ in
            guard let name = alert.textFields?[0].text, let url = self.imagePickerUrl else { return }
            let newPicture = Picture(id: UUID(), path: "", url: url, name: name)
            self.folder.pictures.append(newPicture)
            self.reloadCollectionViewData()
        }
        let noAction = UIAlertAction(title: "취소", style: .cancel)

        alert.addAction(okAction)
        alert.addAction(noAction)
        alert.addTextField { textField in
            textField.placeholder = "사진 이름"
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc
    private func columnButtonTapped() {
        column = column == 1 ? 2 : column == 2 ? 3 : 1
        setupNavigationBar()
        reloadCollectionViewData()
    }
    
    private func setupCollectionView() {
        folderCollectionView.delegate = self
        folderCollectionView.dataSource = self
        folderCollectionView.register(DataCell.self, forCellWithReuseIdentifier: DataCell.identifier)
        
        pictureCollectionView.delegate = self
        pictureCollectionView.dataSource = self
        pictureCollectionView.register(DataCell.self, forCellWithReuseIdentifier: DataCell.identifier)
        
        view.addSubview(folderCollectionView)
        view.addSubview(pictureCollectionView)
        
        let height = getFolderCollectionViewHeight()

        folderCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(92)
            $0.left.right.equalToSuperview().inset(leftRightPadding)
            $0.height.equalTo(height)
        }
        pictureCollectionView.snp.makeConstraints {
            $0.top.equalTo(folderCollectionView.snp.bottom)
            $0.bottom.left.right.equalToSuperview().inset(leftRightPadding)
        }
    }
    
    private func updateFolderCollectionViewHeight() {
        let height = getFolderCollectionViewHeight()
        
        folderCollectionView.snp.updateConstraints {
            $0.height.equalTo(height)
        }
    }
    
    private func getFolderCollectionViewHeight() -> CGFloat {
        let cellHeight = (view.frame.width - leftRightPadding * (column + 1)) / column + extraHeightPadding
        let rowCount = CGFloat(ceil(Double(folder.folders.count) / Double(column)))
        let folderViewHeight = (cellHeight + topBottomPadding) * rowCount
    
        return folderViewHeight
    }
}

extension MainViewController:  UINavigationControllerDelegate, UIImagePickerControllerDelegate {
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

extension MainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case folderCollectionView: return folder.folders.count
        case pictureCollectionView: return folder.pictures.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DataCell.identifier, for: indexPath) as! DataCell

        switch collectionView {
        case folderCollectionView: cell.folder = folder.folders[indexPath.row]
        case pictureCollectionView: cell.picture = folder.pictures[indexPath.row]
        default: return UICollectionViewCell()
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
        if collectionView == folderCollectionView {
            let folderVC = FolderViewController(folder.folders[indexPath.row])
            self.navigationController?.pushViewController(folderVC, animated: true)
        } else if collectionView == pictureCollectionView {
            let pictureVC = PictureViewController(folder.pictures[indexPath.row])
            pictureVC.modalPresentationStyle = .overCurrentContext
            self.present(pictureVC, animated: true, completion: nil)
        }
    }
}
