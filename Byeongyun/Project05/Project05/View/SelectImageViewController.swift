//
//  DetailViewController.swift
//  Project05
//
//  Created by ITlearning on 2021/10/09.
//

import UIKit

class SelectImageViewController: UIViewController {
    
    private var mainSelectIndex: Int
    
    private var array: [URL] = []
    
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
    
    init(index: Int, array: [URL]) {
        mainSelectIndex = index
        self.array += array
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func settingCollectionView() {
        detailCollectionView.register(DetailImageCollectionViewCell.self, forCellWithReuseIdentifier: DetailImageCollectionViewCell.cellId)
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
    }
    
    private func settingUI() {
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.leading.equalTo(view.snp.leading).offset(20)
        }
        
        view.addSubview(detailCollectionView)
        detailCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top)
            $0.leading.equalTo(view.snp.leading)
            $0.trailing.equalTo(view.snp.trailing)
            $0.bottom.equalTo(view.snp.bottom)
        }
        
        view.addSubview(imageIndexLabel)
        imageIndexLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        
        self.view.bringSubviewToFront(cancelButton)
        self.detailCollectionView.layoutIfNeeded()
        self.detailCollectionView.scrollToItem(at: IndexPath(item: self.mainSelectIndex, section: 0), at: .centeredHorizontally, animated: false)
    }

}

extension SelectImageViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailImageCollectionViewCell.cellId, for: indexPath) as? DetailImageCollectionViewCell else { return UICollectionViewCell() }
        cell.detailImage = array[indexPath.row]

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(indexPath.row)
        if let itemCell = cell as? DetailImageCollectionViewCell {
            itemCell.scrollZoomSize = CGFloat(1.0)
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        imageIndexLabel.text = "\(indexPath.row + 1) / \(self.array.count)"
    }
}
