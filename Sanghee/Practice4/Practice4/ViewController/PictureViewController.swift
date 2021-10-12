//
//  PictureViewController.swift
//  Practice4
//
//  Created by leeesangheee on 2021/10/09.
//

import UIKit

class PictureViewController: UIViewController, UIScrollViewDelegate {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .black
        return scrollView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let cancelBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        return imageView
    }()
    
    let picture: Picture
    
    init(_ picture: Picture) {
        self.picture = picture
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        setupDoubleTap()
        setupTitleLabel()
        setupButton()
        setupPictureView()
    }
    
    @objc
    private func buttonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
        scrollView.isScrollEnabled = true
        
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
    }
    
    private func setupDoubleTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDoubleTapped))
        tapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func viewDoubleTapped() {
        scrollView.zoomScale = 1.0
    }
    
    private func setupTitleLabel() {
        titleLabel.text = picture.name
        
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupButton() {
        view.addSubview(cancelBtn)
        
        cancelBtn.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.left.equalToSuperview().inset(16)
        }
    }
    
    private func setupPictureView() {
        let image = UIImage(contentsOfFile: picture.url.path)
        imageView.image = image
        
        scrollView.addSubview(imageView)

        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(64)
            $0.width.equalTo(view.frame.width - 32)
            $0.height.equalTo(view.frame.height - 80)
            $0.centerX.equalToSuperview()
        }
    }
}
