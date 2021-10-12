//
//  DetailViewController.swift
//  Practice3
//
//  Created by leeesangheee on 2021/10/02.
//

import SnapKit
import UIKit

class DetailViewController: UIViewController {
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private let mainUnitView = MainUnitView()
    
    private let deleteBtn: UIButton = {
        let button = UIButton(type: .close)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    var mainUnit: MainUnit? {
        didSet {
            setCollectionView()
            setMainUnitView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc
    private func buttonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DetailViewController: DetailView {
    func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DetailCollectionCell.self, forCellWithReuseIdentifier: DetailCollectionCell.identifier)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
    }
    
    func setMainUnitView() {
        mainUnitView.mainUnit = mainUnit
        
        view.addSubview(mainUnitView)
        mainUnitView.addSubview(deleteBtn)
        
        mainUnitView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.width.height.equalTo(view.bounds.width)
        }
        
        deleteBtn.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.right.equalToSuperview().inset(16)
        }
    }
}

extension DetailViewController:  UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainUnit?.detailUnits.count ?? 0
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let mainUnit = mainUnit else { return UICollectionViewCell() }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionCell.identifier, for: indexPath) as! DetailCollectionCell
        cell.detailUnit = mainUnit.detailUnits[indexPath.row]
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 32
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: view.frame.width, left: 16, bottom: 0, right: 16)
    }
}

extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        let safeAreaTop = scrollView.safeAreaInsets.top
        
        let scrollLength = contentOffsetY + safeAreaTop
        let minimumPullLength : CGFloat = -120
        
        // 아래로 스크롤
        if scrollLength > 0 {
            mainUnitView.snp.updateConstraints {
                $0.top.equalToSuperview().offset(-scrollLength)
            }
        } else {
            mainUnitView.snp.updateConstraints {
                $0.top.equalToSuperview()
            }
        }
        
        // 위로 당김
        if scrollLength < minimumPullLength {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
