//
//  MainViewController.swift
//  Practice3
//
//  Created by leeesangheee on 2021/10/02.
//

import SnapKit
import UIKit

class MainViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let mainPresenter = MainPresenter()
    var mainUnits: [MainUnit] = []
    
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
        
        collectionView.register(CustomCollectionCell.self, forCellWithReuseIdentifier: CustomCollectionCell.identifier)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainUnits.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionCell.identifier, for: indexPath) as! CustomCollectionCell
        cell.mainUnit = mainUnits[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 100, left: 0, bottom:0, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.mainUnit = mainUnits[indexPath.row]
        detailVC.modalPresentationStyle = .overFullScreen
        detailVC.transitioningDelegate = self
        
        self.present(detailVC, animated: true, completion: nil)
    }
}

extension MainViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let selectedIndexPath = collectionView.indexPathsForSelectedItems,
              let selectedCell = collectionView.cellForItem(at: selectedIndexPath.first!),
              let selectedCellSuperView = selectedCell.superview else { return nil }
        
        let animator = PopAnimator(view: selectedCell)
        animator.originFrame = selectedCellSuperView.convert(selectedCell.frame, to: nil)
        return animator
    }
}

extension MainViewController: MainView {
    func setHeader() {
        timeLabel = {
            let label = UILabel()
            label.text = "10월 3일 일요일"
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
