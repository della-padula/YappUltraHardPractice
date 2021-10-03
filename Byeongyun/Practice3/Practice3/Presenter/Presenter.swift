//
//  Presenter.swift
//  Practice3
//
//  Created by ITlearning on 2021/10/03.
//

import UIKit

protocol ViewProtocol {
    func registerCells(for collectionView: UICollectionView)
}

class Presenter: NSObject, ViewProtocol {
    let model = Model()
    let backgroundColor: UIColor = .white
    private var images: [UIImage?] {
        return model.images
    }
    private var subStrings: [String] {
        return model.subTitles
    }
    private var mainStrings: [String] {
        return model.mainTitles
    }
    let cellId = "MainCell"
    
    func registerCells(for collectionView: UICollectionView) {
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
}

extension Presenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        cell.cellMainImage = images[indexPath.row]
        cell.cellMainString = mainStrings[indexPath.row]
        cell.cellSubString = subStrings[indexPath.row]
        
        return cell
    }
    
    
}
