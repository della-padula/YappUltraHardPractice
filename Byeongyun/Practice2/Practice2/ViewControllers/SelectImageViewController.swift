//
//  SelectImageViewController.swift
//  Practice2
//
//  Created by ITlearning on 2021/10/01.
//

import UIKit

class SelectImageViewController: UIViewController {

    private let mainSelectIndex: Int
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        return button
    }()
    
    private var imageIndexLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "0/3"
        label.textColor = .white
        
        return label
    }()
    
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
    
    init(index: Int) {
        mainSelectIndex = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func settingCollectionView() {
        detailCollectionView.register(DetaillmageCollectionViewCell.self, forCellWithReuseIdentifier: DetaillmageCollectionViewCell.cellId)
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
    }
    
    private func settingUI() {
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
        
        view.addSubview(imageIndexLabel)
        imageIndexLabel.translatesAutoresizingMaskIntoConstraints = false
        imageIndexLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        imageIndexLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        self.view.bringSubviewToFront(cancelButton)
        self.detailCollectionView.layoutIfNeeded()
        self.detailCollectionView.scrollToItem(at: IndexPath(item: self.mainSelectIndex, section: 0), at: .centeredHorizontally, animated: false)
    }
}

extension SelectImageViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetaillmageCollectionViewCell.cellId, for: indexPath) as? DetaillmageCollectionViewCell else { return UICollectionViewCell() }
        cell.detailCellImage = imageArray[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let itemCell = cell as? DetaillmageCollectionViewCell {
            itemCell.scrollZoomSize = CGFloat(1.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        imageIndexLabel.text = "\(indexPath.row + 1) / \(imageArray.count)"
    }
}
