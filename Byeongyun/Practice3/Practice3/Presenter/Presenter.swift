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
}

protocol CellProtocol {
    func collapse()
    func expand(in collectionView: UICollectionView)
}

class Presenter: NSObject, ViewProtocol {
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
    
    let cellId = "MainCell"
    let detailCellId = "DetailCell"
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
}
/*
extension Presenter: UICollectionViewDataSource {
    /*
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        cell.cellMainImage = images[indexPath.row]
        cell.cellMainString = mainStrings[indexPath.row]
        cell.cellSubString = subStrings[indexPath.row]
        //cell.cellExplainAppString = explainString
        
        return cell
    }
    
    */
}
 */
