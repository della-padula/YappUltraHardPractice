//
//  DetailViewController.swift
//  Practice3
//
//  Created by ITlearning on 2021/10/03.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass
import SnapKit

class DetailViewController: UIViewController {
    
    private let presenter = Presenter()
    private let cellId = "DetailCell"
    private let detailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        //imageView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        return imageView
    }()
    
    private let detailMainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.text = "BMW R 18에 올라타!"
        label.textColor = .white
        return label
    }()
    
    private let detailSubLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.text = "SPECIAL EVENT"
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return label
    }()
    
    private lazy var cellDetailStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [detailSubLabel, detailMainLabel])
        cellDetailStackView.axis = .vertical
        cellDetailStackView.alignment = .leading
        cellDetailStackView.spacing = 1
        
        return stackView
    }()
    
    private let appImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "kart_icon"))
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let appMainLabel: UILabel = {
        let label = UILabel()
        label.text = "KartRider Rush+"
        label.font = UIFont.systemFont(ofSize: 13)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        
        return label
    }()
    
    private let appSubLabel: UILabel = {
        let label = UILabel()
        label.text = "Real-time Kart Racing Thrill"
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .systemGray
        
        return label
    }()
    
    private lazy var subStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [appMainLabel, appSubLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 1
        
        return stackView
    }()
    
    private let openButton: UIButton = {
        let button = UIButton()
        button.setTitle("OPEN", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 13
        
        return button
    }()
    
    private let cellSubView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    private let detailCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 450, left: 20, bottom: 0, right: 20)
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - 30, height: 800)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
         
        return collectionView
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.tintColor = .white
        return button
    }()
    
    
    @objc
    func cancelButtonAction() {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.cancelButton.alpha = 0.0
        })
        
        dismiss(animated: true, completion: nil)
    }
    
    private let dismissButton = UIButton()
    
    init(image: UIImage, mainText: String, subText: String) {
        super.init(nibName: nil, bundle: nil)
        detailImageView.image = image
        detailMainLabel.text = mainText
        detailSubLabel.text = subText
        cancelButton.alpha = 1.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCollectionView() {
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
        presenter.registerCells(for: detailCollectionView, num: 2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let recognizer = InstantPanGestureRecognizer(target: self, action: #selector(panRecognizer))
        //detailCollectionView.addGestureRecognizer(recognizer)
        dismissButton.addGestureRecognizer(recognizer)
        configureUI()
        configureCollectionView()
    }
    
    var animationProgress: CGFloat = 0.0
    @objc
    func panRecognizer(recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: dismissButton)
        switch recognizer.state {
        case .began:
            shrinkAnimation()
            animationProgress = animator.fractionComplete
            animator.pauseAnimation()
        case .changed:
            let fraction = translation.y / 100
            print(fraction)
            //print(fraction)
            animator.fractionComplete = fraction + animationProgress
            if animator.fractionComplete > 0.99 {
                animator.stopAnimation(true)
                UIView.animate(withDuration: 0.5, animations: {
                    self.cancelButton.alpha = 0.0
                    //self.view.alpha = 0.0
                })
                dismiss(animated: true, completion: nil)
            }
        case .ended:
            if animator.fractionComplete == 0 {
                print("올리면 이리로 오나?")
                animator.stopAnimation(true)
                //dismiss(animated: true, completion: nil)
            } else {
                animator.isReversed = true
                animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            }
        default:
            break
        }
    }
    var animator = UIViewPropertyAnimator()
    func shrinkAnimation() {
        animator = UIViewPropertyAnimator(duration: 1.0, curve: .easeOut, animations: {
            self.view.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
            self.view.layer.cornerRadius = 15
        })
        animator.startAnimation()
    }
    
    private func configureUI() {
        view.addSubview(detailCollectionView)
        detailCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }

        detailCollectionView.addSubview(detailImageView)
        detailImageView.snp.makeConstraints {
            $0.top.equalTo(detailCollectionView.snp.top)
            $0.leading.equalTo(detailCollectionView.snp.leading)
            $0.trailing.equalTo(detailCollectionView.snp.trailing)
            $0.width.equalTo(view.safeAreaLayoutGuide.snp.width)
            $0.height.equalTo(140)
        }
        
        detailCollectionView.addSubview(detailSubLabel)
        detailSubLabel.snp.makeConstraints {
            $0.top.equalTo(detailCollectionView.snp.top).offset(10)
            $0.leading.equalTo(detailCollectionView.snp.leading).offset(10)
        }
        
        detailCollectionView.addSubview(detailMainLabel)
        detailMainLabel.snp.makeConstraints {
            $0.top.equalTo(detailSubLabel.snp.bottom).offset(5)
            $0.leading.equalTo(detailCollectionView.snp.leading).offset(10)
        }
        
        detailCollectionView.addSubview(dismissButton)
        dismissButton.snp.makeConstraints {
            $0.top.equalTo(detailCollectionView.snp.top).offset(30)
            $0.leading.equalTo(detailCollectionView.snp.leading)
            $0.trailing.equalTo(detailCollectionView.snp.trailing)
            $0.width.equalTo(detailCollectionView.snp.width)
            $0.height.equalTo(200)
        }
        
        detailCollectionView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(detailCollectionView.snp.top)
            $0.trailing.equalTo(detailCollectionView.snp.trailing).offset(-15)
            $0.width.equalTo(40)
            $0.height.equalTo(40)
        }
        
        detailImageView.addSubview(cellSubView)
        cellSubView.snp.makeConstraints {
            $0.leading.equalTo(detailImageView.snp.leading)
            $0.trailing.equalTo(detailImageView.snp.trailing)
            $0.bottom.equalTo(detailImageView.snp.bottom).offset(280)
            $0.height.equalTo(80)
        }
        
        cellSubView.addSubview(appImageView)
        appImageView.snp.makeConstraints {
            $0.top.equalTo(cellSubView.snp.top).offset(13)
            $0.leading.equalTo(cellSubView.snp.leading).offset(10)
            //$0.centerY.equalToSuperview()
            $0.height.equalTo(45)
            $0.width.equalTo(45)
        }
        
        cellSubView.addSubview(openButton)
        openButton.snp.makeConstraints {
            $0.top.equalTo(cellSubView.snp.top).offset(25)
            $0.trailing.equalTo(cellSubView.snp.trailing).offset(-20)
            $0.width.equalTo(60)
            $0.height.equalTo(25)
        }
        
        cellSubView.addSubview(subStackView)
        subStackView.snp.makeConstraints {
            $0.top.equalTo(cellSubView.snp.top).offset(13)
            $0.leading.equalTo(appImageView.snp.trailing).offset(10)
            $0.trailing.equalTo(openButton.snp.leading).offset(-30)
        }
        
        
        view.bringSubviewToFront(dismissButton)
    }
    
    
}


class InstantPanGestureRecognizer: UIPanGestureRecognizer {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if self.state == UIGestureRecognizer.State.began {
            return
        }
        super.touchesBegan(touches, with: event)
        self.state = UIGestureRecognizer.State.began
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId , for: indexPath) as? DetailCollectionViewCell else { return UICollectionViewCell() }
        let model = Model()
        
        cell.explainString = model.explainText
        
        return cell
    }
    
    
}
