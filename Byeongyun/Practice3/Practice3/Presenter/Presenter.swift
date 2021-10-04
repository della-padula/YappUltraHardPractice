//
//  Presenter.swift
//  Practice3
//
//  Created by ITlearning on 2021/10/03.
//

import UIKit

protocol ViewProtocol {
    func registerCells(for collectionView: UICollectionView, num: Int)
    func loadImage(index: Int) -> UIImage
    func loadMainString(index: Int) -> String
    func loadSubString(index: Int) -> String
    func loadImageCount() -> Int
    func loadExplain() -> String
}

protocol CellProtocol {
    func collapse()
    func expand(in collectionView: UICollectionView)
}


class Presenter: NSObject, ViewProtocol, UIViewControllerTransitioningDelegate {
    let model = Model()
    let backgroundColor: UIColor = .white
    let transition = Transition()
    
    private var images: [UIImage?] {
        return model.images
    }
    private var subStrings: [String] {
        return model.subTitles
    }
    private var mainStrings: [String] {
        return model.mainTitles
    }
    
    private var explainString: String {
        return model.explainText
    }
    
    private let cellId = "MainCell"
    private let detailCellId = "DetailCell"
    func registerCells(for collectionView: UICollectionView, num: Int) {
        if num == 1 {
            collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        } else {
            collectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: detailCellId)
        }
        
    }
    
    func loadImage(index: Int) -> UIImage {
        guard let image = images[index] else { return UIImage() }
        return image
    }
    
    func loadMainString(index: Int) -> String {
        let mainString = mainStrings[index]
        return mainString
    }
    
    func loadSubString(index: Int) -> String {
        let subString = subStrings[index]
        return subString
    }
    
    func loadImageCount() -> Int {
        return images.count
    }
    
    func loadExplain() -> String {
        return explainString
    }
}
