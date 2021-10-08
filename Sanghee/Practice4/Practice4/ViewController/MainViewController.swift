//
//  MainViewController.swift
//  Practice4
//
//  Created by leeesangheee on 2021/10/08.
//

import SnapKit
import UIKit

class MainViewController: UIViewController  {
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private let folders: [Folder] = [Folder(path: "", name: "폴더 1", pictures: [Picture(path: "", name: "사진 1"), Picture(path: "", name: "사진 2")]),
                                     Folder(path: "", name: "폴더 2", pictures: [Picture(path: "", name: "사진 1"), Picture(path: "", name: "사진 2")]),
                                     Folder(path: "", name: "폴더 3", pictures: [Picture(path: "", name: "사진 1"), Picture(path: "", name: "사진 2")]),
                                     Folder(path: "", name: "폴더 4", pictures: [Picture(path: "", name: "사진 1"), Picture(path: "", name: "사진 2")]),
                                     Folder(path: "", name: "폴더 5", pictures: [Picture(path: "", name: "사진 1"), Picture(path: "", name: "사진 2")]),
                                     Folder(path: "", name: "폴더 6", pictures: [Picture(path: "", name: "사진 1"), Picture(path: "", name: "사진 2")]),
                                     Folder(path: "", name: "폴더 7", pictures: [Picture(path: "", name: "사진 1"), Picture(path: "", name: "사진 2")]),
                                     Folder(path: "", name: "폴더 8", pictures: [Picture(path: "", name: "사진 1"), Picture(path: "", name: "사진 2")]),
    ]
    private let pictures: [Picture] = [Picture(path: "", name: "사진 1"),
                                       Picture(path: "", name: "사진 2"),
                                       Picture(path: "", name: "사진 3"),
                                       Picture(path: "", name: "사진 4"),
                                       Picture(path: "", name: "사진 5"),
                                       Picture(path: "", name: "사진 6"),
                                       Picture(path: "", name: "사진 7"),
                                       Picture(path: "", name: "사진 8"),
                                       Picture(path: "", name: "사진 9"),
                                       Picture(path: "", name: "사진 10"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBar()
        setupCollectionView()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "사진 탐색기"
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc
    private func addButtonTapped() {
        print("추가 버튼 클릭됨")
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

extension MainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return folders.count + pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DataCell.identifier, for: indexPath) as! DataCell
        
        if indexPath.row < folders.count {
            cell.folder = folders[indexPath.row]
        } else {
            cell.picture = pictures[indexPath.row - folders.count]
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
        if indexPath.row < folders.count {
            let folderVC = FolderViewController()
            folderVC.folder = folders[indexPath.row]
            self.navigationController?.pushViewController(folderVC, animated: true)
        } else {
            print("\(pictures[indexPath.row - folders.count].name) 사진이 클릭됨")
        }
    }
}
