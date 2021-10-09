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
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo.fill")
        imageView.tintColor = .systemGray
        return imageView
    }()
    private let cancelBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    var picture: Picture?
    
    init(_ picture: Picture) {
        super.init(nibName: nil, bundle: nil)
        self.picture = picture
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        setupDoubleTap()
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
    
    private func setupButton() {
        view.addSubview(cancelBtn)
        
        cancelBtn.snp.makeConstraints {
            $0.top.equalToSuperview().inset(64)
            $0.left.equalToSuperview().inset(16)
        }
    }
    
    private func setupPictureView() {
        guard let url = picture?.url else { return }
        
        let image = UIImage(contentsOfFile: url.path)
        imageView.image = image
        
        scrollView.addSubview(imageView)

        imageView.snp.makeConstraints {
            $0.width.height.equalTo(view.frame.width - 32)
            $0.center.equalToSuperview()
        }
    }
}
