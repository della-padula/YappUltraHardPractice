//
//  ViewController.swift
//  Practice2
//
//  Created by ITlearning on 2021/09/30.
//

import UIKit
import PhotosUI

class MainViewController: UIViewController {
    
    private var itemProviders: [NSItemProvider] = []
    private var iterator: IndexingIterator<[NSItemProvider]>?
    private var imageArray: [UIImage] = [UIImage(named: "ddd")!]
    private var sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    private let mainTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "Image Picker"
        return label
    }()
    
    private let selectButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .purple
        button.setTitle("사진 선택", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(selectAction), for: .touchUpInside)
        return button
    }()
    
    private let imageCollectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.minimumLineSpacing = 20
        flowlayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        flowlayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    @objc
    func selectAction() {
        print(imageArray.count)
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 0
        configuration.filter = .any(of: [.images, .livePhotos])
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionViewSetting()
        settingUI()
    }
    
    private func collectionViewSetting() {
        imageCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.cellId)
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
    }
    
    private func settingUI() {
        view.addSubview(mainTitle)
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        mainTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35).isActive = true
        mainTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        
        view.addSubview(selectButton)
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        selectButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
        selectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        selectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        
        view.addSubview(imageCollectionView)
        imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        imageCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageCollectionView.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 150).isActive = true
        imageCollectionView.bottomAnchor.constraint(equalTo: selectButton.topAnchor, constant: -150).isActive = true
        
    }

}


extension MainViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        itemProviders = results.map(\.itemProvider)
        iterator = itemProviders.makeIterator()
        for item in itemProviders {
            if item.canLoadObject(ofClass: UIImage.self) {
                item.loadObject(ofClass: UIImage.self) { image, error in
                    DispatchQueue.main.async {
                        guard let image = image as? UIImage else { return }
                        self.imageArray.append(image)
                        self.imageCollectionView.reloadData()
                        print(self.imageArray)
                    }
                }
            }
        }
    }
    
    
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.cellId, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        cell.settingImageView = imageArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 80, height: collectionView.frame.height)
    }
    
}
