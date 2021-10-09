//
//  PictureViewController.swift
//  Practice4
//
//  Created by leeesangheee on 2021/10/09.
//

import UIKit

class PictureViewController: UIViewController {
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
        
        setupView()
        setupButton()
        setupPictureView()
    }
    
    @objc
    private func buttonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupView() {
        view.backgroundColor = .black
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
        
        view.addSubview(imageView)

        imageView.snp.makeConstraints {
            $0.width.height.equalTo(view.frame.width - 32)
            $0.center.equalToSuperview()
        }
    }
}
