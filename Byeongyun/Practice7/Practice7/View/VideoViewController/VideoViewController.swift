//
//  VideoViewController.swift
//  Practice7
//
//  Created by ITlearning on 2021/10/20.
//

import UIKit
import SnapKit
import AVFoundation

class VideoViewController: UIViewController, VideoViewProtocol {

    override var prefersStatusBarHidden: Bool {
        return true
    }

    func updateCurrentPlayer() {
        videoCollectionView.reloadData()
    }

    private var index: Int
    private var presenter: VideoPresenterProtocol!
    private var launcher: VideoLauncher = VideoLauncher()
    var player = AVPlayer()
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

    private var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activity.alpha = 1.0
        activity.color = .white
        activity.style = .medium
        return activity
    }()

    private let videoCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()

    private let videoControlButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(videoStatus), for: .touchUpInside)
        return button
    }()

    @objc
    func videoStatus() {

        if VideoLauncher.isPlaying {
            VideoLauncher.player?.pause()
            videoControlButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            VideoLauncher.player?.play()
            videoControlButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }

        VideoLauncher.isPlaying = !VideoLauncher.isPlaying
    }

    private let videoLengthLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .right
        return label
    }()

    private lazy var videoSlider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.setThumbImage(UIImage(named: "thumb"), for: .normal)

        slider.addTarget(self, action: #selector(moveSliderChange), for: .valueChanged)
        return slider
    }()

    @objc
    func moveSliderChange() {
        print(videoSlider.value)

        if let duration = VideoLauncher.player?.currentItem!.asset.duration {
            let seconds = CMTimeGetSeconds(duration)

            let value = Float64(videoSlider.value) * seconds
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            VideoLauncher.player?.seek(to: seekTime, completionHandler: { _ in

            })
        }



    }

    init(_ index: Int) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
        presenter = VideoPresenter(view: self)
        presenter.loadVideoList()
        print("비디오 상태: ",VideoLauncher.isPlaying)
        buttonStatus()
        getTime()
    }

    private func buttonStatus() {
        if VideoLauncher.isPlaying {
            videoControlButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        } else {
            videoControlButton.setImage(UIImage(systemName: "play.fill"), for: .normal)

        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureLayout()
        presenter.loadVideoList()
        configureCollectionView()

        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerHandler(_:))))
    }

    @objc
    func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .changed:
            initialTouchPoint = sender.translation(in: view)
            print(initialTouchPoint.y)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                print(self.initialTouchPoint.y)
                self.view.transform = CGAffineTransform(translationX: 0, y: self.initialTouchPoint.y)
            })
            if initialTouchPoint.y > 250 && initialTouchPoint.y < 410 {
                videoPlayView.layer.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 250 - (initialTouchPoint.y-250))
                VideoLauncher.playerLayer?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 250 - (initialTouchPoint.y-250))
            } else if initialTouchPoint.y > 410 {
                videoPlayView.layer.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 250 - (initialTouchPoint.y-250))
                VideoLauncher.playerLayer?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 250 - (initialTouchPoint.y-250))
            }
        case .ended:
            if initialTouchPoint.y < 300 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: { print(self.initialTouchPoint.y)
                    self.view.transform = .identity
                    //self.videoPlayView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 230)
                    VideoLauncher.playerLayer?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 250)
                })
            } else {
                dismiss(animated: true, completion: {
                    NotificationCenter.default.post(name: NSNotification.Name("dismiss"), object: nil, userInfo: nil)

                })
                //launcher.player.pause()
            }
        default:
            break
        }
    }


    private func configureCollectionView() {
        videoCollectionView.delegate = self
        videoCollectionView.dataSource = self
        videoCollectionView.register(VideoInfoCollectionViewCell.self, forCellWithReuseIdentifier: VideoInfoCollectionViewCell.cellId)
        videoCollectionView.register(ChannelInfoCollectionViewCell.self, forCellWithReuseIdentifier: ChannelInfoCollectionViewCell.cellId)
    }

    private func configureLayout() {
        activityIndicator.startAnimating()
        if let url = URL(string: presenter.getVideo()[index].videoUrl) {
            if VideoLauncher.player == nil {
                VideoLauncher.player = AVPlayer(url: url)
                videoControlButton.isHidden = true
            }
            print(VideoLauncher.currentPlayindex, index)
            if VideoLauncher.currentPlayindex == index {
                self.view.addSubview(videoPlayView)
                videoPlayView.snp.makeConstraints {
                    $0.top.equalTo(view.snp.top)
                    $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
                    $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
                    $0.width.equalTo(view.snp.width)
                    $0.height.equalTo(250)
                }

                if VideoLauncher.playerLayer == nil {
                    videoControlButton.isHidden = true
                    VideoLauncher.playerLayer = AVPlayerLayer(player: VideoLauncher.player)
                    VideoLauncher.player?.play()
                    self.videoPlayView.layer.addSublayer(VideoLauncher.playerLayer!)
                    self.videoPlayView.addSubview(activityIndicator)
                    activityIndicator.snp.makeConstraints {
                        $0.centerX.equalTo(videoPlayView.snp.centerX)
                        $0.centerY.equalTo(videoPlayView.snp.centerY)
                        $0.height.equalTo(70)
                        $0.width.equalTo(70)
                    }
                } else {
                    self.videoPlayView.layer.addSublayer(VideoLauncher.playerLayer!)
                }
                VideoLauncher.playerLayer?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 250)
                VideoLauncher.player?.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status) , options: [.old, .new], context: nil)
            } else {
                videoControlButton.isHidden = true
                VideoLauncher.player?.pause()
                VideoLauncher.player = nil
                VideoLauncher.player = AVPlayer(url: url)
                VideoLauncher.playerLayer = nil
                VideoLauncher.currentPlayindex = index
                self.showVideo()
            }

            self.videoPlayView.addSubview(videoControlButton)
            videoControlButton.snp.makeConstraints {
                $0.centerX.equalTo(videoPlayView.snp.centerX)
                $0.centerY.equalTo(videoPlayView.snp.centerY)
                $0.height.equalTo(70)
                $0.width.equalTo(70)
            }
            self.videoPlayView.addSubview(videoLengthLabel)
            videoLengthLabel.snp.makeConstraints {
                $0.bottom.equalToSuperview()
                $0.trailing.equalToSuperview().offset(-4)
                $0.width.equalTo(50)
                $0.height.equalTo(24)
            }
            self.videoPlayView.addSubview(videoSlider)
            videoSlider.snp.makeConstraints {
                $0.trailing.equalTo(videoLengthLabel.snp.leading)
                $0.bottom.equalToSuperview()
                $0.leading.equalToSuperview()
            }
        }

        view.addSubview(videoCollectionView)
        videoCollectionView.snp.makeConstraints {
            $0.top.equalTo(videoPlayView.snp.bottom)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)

        }
    }

    private func showVideo() {
        VideoLauncher.playerLayer = AVPlayerLayer(player: VideoLauncher.player)

        self.videoPlayView.layer.addSublayer(VideoLauncher.playerLayer!)

        self.view.addSubview(videoPlayView)
        videoPlayView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top)
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
        VideoLauncher.playerLayer?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 250)
        VideoLauncher.player?.play()
        VideoLauncher.player?.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status) , options: [.old, .new], context: nil)
    }

    private func getTime() {
        if VideoLauncher.player != nil {
            if VideoLauncher.currentPlayindex != index {
                videoLengthLabel.text = "00:00"
            } else {
                let seconds = CMTimeGetSeconds((VideoLauncher.player?.currentItem!.asset.duration)!)
                print("영상시간:",seconds)
                let secondsText = String(format: "%02d", Int(seconds)%60)
                let minText = String(format: "%02d", Int(seconds)/60)
                videoLengthLabel.text = "\(minText):\(secondsText)"
            }
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
                videoControlButton.isHidden = false
                VideoLauncher.isPlaying = true
                getTime()
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

extension VideoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoInfoCollectionViewCell.cellId, for: indexPath) as? VideoInfoCollectionViewCell else { return UICollectionViewCell() }
            cell.configureData(presenter.getVideo()[index])

            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChannelInfoCollectionViewCell.cellId, for: indexPath) as? ChannelInfoCollectionViewCell else { return UICollectionViewCell() }
            cell.configureData(presenter.getVideo()[index])

            return cell
        default:
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        if indexPath.item == 0 {
            return CGSize(width: width, height: 80)
        } else if indexPath.item == 1 {
            return CGSize(width: width, height: 40)
        }

        return CGSize(width: width, height: 80)
    }

}
