//
//  SelectImageViewController.swift
//  Practice2
//
//  Created by ITlearning on 2021/10/01.
//

import UIKit

class SelectImageViewController: UIViewController {

    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        return button
    }()
    
    private var select: Int = 0
    
    var settingIndexPath: Int? {
        didSet {
            guard let setting = settingIndexPath else { return }
            select = setting
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let index = IndexPath(row: select, section: 0)
        DispatchQueue.main.async {
            self.detailCollectionView.selectItem(at: index, animated: false, scrollPosition: .left)
        }
    }
    
    private let detailCollectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowlayout.minimumLineSpacing = 0
        flowlayout.minimumInteritemSpacing = 0
        flowlayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        collectionView.backgroundColor = .black
        return collectionView
    }()
    
    @objc
    func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        detailCollectionView.isPagingEnabled = true
        settingCollectionView()
        settingUI()
    }
    
    func settingCollectionView() {
        detailCollectionView.register(DetaillmageCollectionViewCell.self, forCellWithReuseIdentifier: DetaillmageCollectionViewCell.cellId)
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
    }
    
    func settingUI() {
        view.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        view.addSubview(detailCollectionView)
        detailCollectionView.translatesAutoresizingMaskIntoConstraints = false
        detailCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        detailCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        detailCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        detailCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        self.view.bringSubviewToFront(cancelButton)
    }
}

extension SelectImageViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetaillmageCollectionViewCell.cellId, for: indexPath) as? DetaillmageCollectionViewCell else { return UICollectionViewCell() }
        cell.settingImageView = imageArray[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
