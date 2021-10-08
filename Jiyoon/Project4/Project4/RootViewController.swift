//
//  ViewController.swift
//  Project4
//
//  Created by 박지윤 on 2021/10/08.
//

import UIKit
import SnapKit

class RootViewController: UIViewController {
    var rightButton = UIBarButtonItem()
    let button = UIButton()
    let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: UICollectionViewFlowLayout.init())
    let sectionInset = UIEdgeInsets(top: 20, left: 30, bottom: 20, right: 30)

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }

    func setView() {
        setNavigationItems()
        setCollectionView()
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
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { maker in
            maker.top.equalToSuperview()
            maker.centerX.equalToSuperview()
            maker.height.equalToSuperview()
            maker.width.equalToSuperview()
        }
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
    
    @objc
    func plusButtonPressed(_ sender: UIBarButtonItem) {
        print("pressed")
        let alert = UIAlertController(title: "어떤 것을 추가하시겠습니까?", message: "추가할 파일/폴더의 종류를 선택해주세요.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "사진", style: .default, handler: { _ in
            print("사진")
        
        }))
        alert.addAction(UIAlertAction(title: "폴더", style: .default, handler: { _ in
            print("폴더")
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { (_) in
                    print("취소")
                }))
        self.present(alert, animated: true) {
            print("complete")
        }
    }
}
extension RootViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionFolderCell.identifier, for: indexPath) as! CollectionFolderCell
        
        collectionView.addSubview(cell)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInset
    }
    
}
