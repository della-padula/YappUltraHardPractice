//
//  VideoViewController.swift
//  Practice7
//
//  Created by ITlearning on 2021/10/20.
//

import UIKit
import SnapKit
import AVFoundation

class VideoViewController: UIViewController{

    private let urlString = "https://firebasestorage.googleapis.com/v0/b/writing-3f2f0.appspot.com/o/%E1%84%85%E1%85%A9%E1%84%8B%E1%85%B5%E1%84%8F%E1%85%B5%E1%86%B7(Roy%20Kim)%20-%20%E1%84%89%E1%85%A1%E1%86%AF%E1%84%8B%E1%85%A1%E1%84%80%E1%85%A1%E1%84%82%E1%85%B3%E1%86%AB%20%E1%84%80%E1%85%A5%E1%84%8B%E1%85%A3(Linger%20On)%20M-V.mp4?alt=media&token=05727f59-22c4-461f-bd62-4d95fc0c0a51"

    private let videoPlayView: UIView = {
        let videoView = UIView()
        videoView.backgroundColor = .black

        return videoView
    }()

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

    private let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activity.hidesWhenStopped = false
        activity.startAnimating()
        return activity
    }()

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

        if let url = URL(string: urlString) {
            let player = AVPlayer(url: url)

            let playerLayer = AVPlayerLayer(player: player)
            self.videoPlayView.layer.addSublayer(playerLayer)

            self.view.addSubview(videoPlayView)
            videoPlayView.snp.makeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
                $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
                $0.width.equalTo(view.snp.width)
                $0.height.equalTo(250)

            }
            self.view.addSubview(activityIndicator)
            activityIndicator.snp.makeConstraints {
                $0.centerX.equalTo(videoPlayView.snp.centerX)
                $0.centerY.equalTo(videoPlayView.snp.centerY)
                $0.height.equalTo(70)
                $0.width.equalTo(70)
            }
            playerLayer.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 250)
            player.play()
            player.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status) , options: [.old, .new], context: nil)
        }
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(AVPlayerItem.status) {
            let status: AVPlayerItem.Status
            if let statusNumber = change?[.newKey] as? NSNumber {
                status = AVPlayerItem.Status(rawValue: statusNumber.intValue)!
            } else {
                status = .unknown
            }

            switch status {
            case .readyToPlay:
                activityIndicator.stopAnimating()
                activityIndicator.isHidden = true
            default:
                break
            }
        }
    }
}

extension VideoViewController: UIGestureRecognizerDelegate {
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
