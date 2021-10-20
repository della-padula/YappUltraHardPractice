//
//  VideoViewController.swift
//  Practice7
//
//  Created by ITlearning on 2021/10/20.
//

import UIKit
import SnapKit

class VideoViewController: UIViewController{

    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("닫기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        return button
    }()
    private var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    @objc
    func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureLayout()
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerHandler(_:))))
    }

    @objc
    func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .changed:
            initialTouchPoint = sender.translation(in: view)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                print(self.initialTouchPoint.y)
                self.view.transform = CGAffineTransform(translationX: 0, y: self.initialTouchPoint.y)
            })
        case .ended:
            if initialTouchPoint.y < 300 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: { print(self.initialTouchPoint.y)
                    self.view.transform = .identity
                })
            } else {
                dismiss(animated: true, completion: nil)
            }
        default:
            break
        }
    }

    private func configureLayout() {
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalTo(50)
        }
    }
}

extension VideoViewController: UIGestureRecognizerDelegate {
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
