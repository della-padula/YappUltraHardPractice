//
//  MainViewController.swift
//  Practice3
//
//  Created by leeesangheee on 2021/10/02.
//

import SnapKit
import UIKit

class MainViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let animator = PopAnimator()
    private let mainPresenter = MainPresenter()
    private var mainUnits: [MainUnit] = []
    private var cPointY: CGFloat = 0
    
    private var timeLabel = UILabel()
    private var titleLabel = UILabel()
    private var profileImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        setHeader()
        setCollectionView()
    }
    
    private func getData() {
        mainUnits = mainPresenter.mainUnits
    }
    
    private func setCollectionView() {
        collectionView.backgroundColor = .white
        
        collectionView.register(MainCollectionCell.self, forCellWithReuseIdentifier: MainCollectionCell.identifier)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainUnits.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionCell.identifier, for: indexPath) as! MainCollectionCell
        cell.mainUnit = mainUnits[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 32
        return CGSize(width: width, height: width)
    }

    // 상하 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }

    // 좌우 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 여백
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 100, left: 16, bottom: 0, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.mainUnit = mainUnits[indexPath.row]
        detailVC.modalPresentationStyle = .overFullScreen
        detailVC.transitioningDelegate = self
        
        // 선택한 item y값 저장
        cPointY = getCollectionViewItemCPoint(indexPath: indexPath).y
        
        self.present(detailVC, animated: true, completion: nil)
    }
    
    // 선택한 item y값 얻기
    private func getCollectionViewItemCPoint(indexPath: IndexPath) -> CGPoint {
        let attributes = collectionView.layoutAttributesForItem(at: indexPath)
        let cPoint = collectionView.convert(attributes?.center ?? CGPoint(), to: collectionView.superview)
        
        return cPoint
    }
}

extension MainViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.cPointY = cPointY
        return animator
    }
}

extension MainViewController: MainView {
    func setHeader() {
        timeLabel = {
            let label = UILabel()
            label.text = mainPresenter.currentDateString
            label.font = UIFont.boldSystemFont(ofSize: 14)
            label.textColor = .systemGray
            return label
        }()
        
        titleLabel = {
            let label = UILabel()
            label.text = "투데이"
            label.font = UIFont.boldSystemFont(ofSize: 36)
            return label
        }()
        
        profileImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "person.crop.circle"))
            return imageView
        }()
        
        collectionView.addSubview(timeLabel)
        collectionView.addSubview(titleLabel)
        collectionView.addSubview(profileImageView)
        
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.left.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(4)
            $0.left.equalToSuperview().inset(16)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.top)
            $0.left.equalToSuperview().inset(collectionView.frame.width - 52)
            $0.width.height.equalTo(36)
        }
    }
}
