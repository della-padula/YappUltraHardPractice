//
//  VideoViewController.swift
//  Practice7
//
//  Created by ITlearning on 2021/10/20.
//

import UIKit
import SnapKit
import AVKit

class VideoViewController: UIViewController, VideoViewProtocol {


    override var prefersStatusBarHidden: Bool {
        return true
    }

    func updateCurrentPlayer() {
        videoCollectionView.reloadData()
    }
    private var pictureInPictureController: AVPictureInPictureController?
    private var timer = Timer()
    private var secondToFadeOut = 5
    private var isTimerRunning: Bool = false
    private var isAlpha: Bool = true
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
        collectionView.backgroundColor = UIColor.colorSwitch
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

    private let leftSeekView: UIView = {
        let leftView = UIView()
        return leftView
    }()

    private let rightSeekView: UIView = {
        let rightView = UIView()
        return rightView
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
        if let duration = VideoLauncher.player?.currentItem!.asset.duration {
            let seconds = CMTimeGetSeconds(duration)

            let value = Float64(videoSlider.value) * seconds
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            VideoLauncher.player?.seek(to: seekTime, completionHandler: { _ in

            })
        }
    }

    private let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()

    private let nextVideoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrowshape.turn.up.right.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(nextVideoAction), for: .touchUpInside)
        return button
    }()

    private let prevVideoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrowshape.turn.up.backward.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(prevVideoAction), for: .touchUpInside)
        return button
    }()

    private let pipButton: UIButton = {
        let startImage = AVPictureInPictureController.pictureInPictureButtonStartImage
        let button = UIButton(type: .system)
        button.setImage(startImage, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(pipAction), for: .touchUpInside)

        return button
    }()

    @objc
    func pipAction() {
        guard let isActive = pictureInPictureController?.isPictureInPictureActive else { return }

        if isActive {
            pictureInPictureController?.stopPictureInPicture()

            let startImage = AVPictureInPictureController.pictureInPictureButtonStartImage
            pipButton.setImage(startImage, for: .normal)
        } else {
            pictureInPictureController?.startPictureInPicture()

            let stopImage = AVPictureInPictureController.pictureInPictureButtonStopImage
            pipButton.setImage(stopImage, for: .normal)
        }
    }

    @objc
    func prevVideoAction() {
        if 0 <= index-1 {
            index -= 1
            viewDidLoad()
            videoCollectionView.reloadData()
            buttonStatus()
            getTime()
            runTimer()
            getProgressTime()
        }
    }

    @objc
    func nextVideoAction() {
        if index+1 < presenter.getVideo().count-1 {
            index += 1
            viewDidLoad()
            videoCollectionView.reloadData()
            buttonStatus()
            getTime()
            runTimer()
            getProgressTime()
        }

    }

    init(_ index: Int) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
        presenter = VideoPresenter(view: self)
        presenter.loadVideoList()
        buttonStatus()
        getTime()
        runTimer()
        getProgressTime()
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
    // MARK: - ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.colorSwitch
        configureLayout()
        presenter.loadVideoList()
        configureCollectionView()
        configureGesture()
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
        rotated()
        checkPIP()
    }

    private func checkPIP() {
        if AVPictureInPictureController.isPictureInPictureSupported() {
            pictureInPictureController = AVPictureInPictureController(playerLayer: VideoLauncher.playerLayer!)
            pictureInPictureController?.delegate = self
        } else {
            print("Not Supported")
        }
    }

    @objc
    func rotated() {
        if UIDevice.current.orientation.isLandscape {
            videoPlayView.snp.remakeConstraints {
                $0.top.equalTo(view.snp.top)
                $0.leading.equalTo(view.snp.leading)
                $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
                $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
                $0.width.equalTo(view.snp.width)
                $0.height.equalTo(view.snp.height)
            }

            VideoLauncher.playerLayer?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.height)
        }

        if UIDevice.current.orientation.isPortrait {
            videoPlayView.snp.remakeConstraints {
                $0.top.equalTo(view.snp.top)
                $0.leading.equalTo(view.snp.leading)
                $0.trailing.equalTo(view.snp.trailing)
                $0.width.equalTo(view.snp.width)
                $0.height.equalTo(250)
            }
            VideoLauncher.playerLayer?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 250)
        }
    }

    private func configureGesture() {
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerHandler(_:))))
        videoPlayView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapVideo(_:))))
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapVideo(_:)))
        singleTapGesture.numberOfTapsRequired = 1
        leftSeekView.addGestureRecognizer(singleTapGesture)
        let leftDoubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(leftDoubleTapVideo(_:)))
        leftDoubleTapGesture.numberOfTapsRequired = 2
        leftSeekView.addGestureRecognizer(leftDoubleTapGesture)
        rightSeekView.addGestureRecognizer(singleTapGesture)
        let rightDoubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(rightDoubleTapVideo(_:)))
        rightDoubleTapGesture.numberOfTapsRequired = 2
        rightSeekView.addGestureRecognizer(rightDoubleTapGesture)
    }

    @objc
    func rightDoubleTapVideo(_ gestureRecognizer: UITapGestureRecognizer) {
        if let duration = VideoLauncher.player?.currentTime() {
            let seconds = CMTimeGetSeconds(duration)
            let value = seconds + 10
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            VideoLauncher.player?.seek(to: seekTime, completionHandler: { _ in

            })
        }
    }

    @objc
    func leftDoubleTapVideo(_ gestureRecognizer: UITapGestureRecognizer) {
        if let duration = VideoLauncher.player?.currentTime() {
            let seconds = CMTimeGetSeconds(duration)
            let value = seconds - 10
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            VideoLauncher.player?.seek(to: seekTime, completionHandler: { _ in

            })
        }
    }

    @objc
    func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .changed:
            initialTouchPoint = sender.translation(in: view)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.transform = CGAffineTransform(translationX: 0, y: self.initialTouchPoint.y)
            })
            if initialTouchPoint.y > 450 && initialTouchPoint.y < 500 {
                videoPlayView.layer.frame.size = CGSize(width: self.view.frame.width, height: 250 - (initialTouchPoint.y-500))
                VideoLauncher.playerLayer?.frame.size = CGSize(width: 50, height: 50)
                VideoLauncher.playerLayer?.position = CGPoint(x: self.view.frame.minX+35, y: -(initialTouchPoint.y-500)+30)
            }
        case .ended:
            if initialTouchPoint.y < 480 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.view.transform = .identity
                    VideoLauncher.playerLayer?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.videoPlayView.frame.height)
                })
            } else {
                dismiss(animated: true, completion: {
                    NotificationCenter.default.post(name: NSNotification.Name("dismiss"), object: nil, userInfo: nil)
                })
            }
        default:
            break
        }
    }

    @objc
    func tapVideo(_ gestureRecognizer: UITapGestureRecognizer) {
        fadeInButton()
        secondToFadeOut = 5
        timer.invalidate()
        if isTimerRunning == false {
            runTimer()
        } else {
            runTimer()
        }

        if secondToFadeOut >= 0 {
            if isAlpha {
                fadeInButton()
            } else {
                fadeOutButton()
            }
            isAlpha = !isAlpha
        }
    }

    private func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1 , target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        isTimerRunning = true
    }

    @objc
    func updateTimer() {
        secondToFadeOut -= 1
        if secondToFadeOut < 1 {
            fadeOutButton()
            timer.invalidate()
            isTimerRunning = false
        }
    }

    private func fadeInButton() {
        UIView.animate(withDuration: 0.5) {
            self.videoControlButton.alpha = 1
            self.videoSlider.alpha = 1
            self.currentTimeLabel.alpha = 1
            self.videoLengthLabel.alpha = 1
            self.nextVideoButton.alpha = 1
            self.prevVideoButton.alpha = 1
            self.pipButton.alpha = 1
        }
        self.videoControlButton.isEnabled = true
        self.videoSlider.isEnabled = true
        self.currentTimeLabel.isEnabled = true
        self.videoLengthLabel.isEnabled = true
        self.nextVideoButton.isEnabled = true
        self.prevVideoButton.isEnabled = true
        self.pipButton.isEnabled = true
        isAlpha = !isAlpha
    }

    private func fadeOutButton() {
        UIView.animate(withDuration: 0.5) {
            self.videoControlButton.alpha = 0.0
            self.videoSlider.alpha = 0.0
            self.currentTimeLabel.alpha = 0.0
            self.videoLengthLabel.alpha = 0.0
            self.nextVideoButton.alpha = 0.0
            self.prevVideoButton.alpha = 0.0
            self.pipButton.alpha = 0.0
        }
        self.videoControlButton.isEnabled = false
        self.videoSlider.isEnabled = false
        self.currentTimeLabel.isEnabled = false
        self.videoLengthLabel.isEnabled = false
        self.nextVideoButton.isEnabled = false
        self.prevVideoButton.isEnabled = false
        self.pipButton.isEnabled = false
        isAlpha = !isAlpha
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
            if VideoLauncher.currentPlayindex == index {
                self.view.addSubview(videoPlayView)
                videoPlayView.snp.makeConstraints {
                    $0.top.equalTo(view.snp.top)
                    $0.leading.equalTo(view.snp.leading)
                    $0.trailing.equalTo(view.snp.trailing)
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
                $0.bottom.equalToSuperview().offset(-4)
                $0.trailing.equalTo(videoPlayView.safeAreaLayoutGuide.snp.trailing).offset(-4)
                $0.width.equalTo(50)
                $0.height.equalTo(30)
            }

            self.videoPlayView.addSubview(currentTimeLabel)
            currentTimeLabel.snp.makeConstraints {
                $0.leading.equalTo(videoPlayView.safeAreaLayoutGuide.snp.leading).offset(4)
                $0.bottom.equalToSuperview().offset(-4)
                $0.width.equalTo(50)
                $0.height.equalTo(30)
            }

            self.videoPlayView.addSubview(videoSlider)
            videoSlider.snp.makeConstraints {
                $0.trailing.equalTo(videoLengthLabel.snp.leading)
                $0.bottom.equalToSuperview()
                $0.leading.equalTo(currentTimeLabel.snp.trailing)
            }
        }
        videoPlayView.addSubview(leftSeekView)
        leftSeekView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()

            $0.height.equalToSuperview().multipliedBy(0.8)
            $0.width.equalToSuperview().multipliedBy(0.4)
        }

        videoPlayView.addSubview(rightSeekView)
        rightSeekView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.8)
            $0.width.equalToSuperview().multipliedBy(0.4)
        }

        view.addSubview(videoCollectionView)
        videoCollectionView.snp.makeConstraints {
            $0.top.equalTo(videoPlayView.snp.bottom)
            $0.leading.equalTo(view.snp.leading)
            $0.trailing.equalTo(view.snp.trailing)
            $0.bottom.equalTo(view.snp.bottom)
        }

        rightSeekView.addSubview(nextVideoButton)
        nextVideoButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(17)
            $0.width.equalTo(50)
            $0.height.equalTo(50)
        }

        rightSeekView.addSubview(pipButton)
        pipButton.snp.makeConstraints {
            $0.trailing.equalTo(videoPlayView.safeAreaLayoutGuide.snp.trailing).offset(-4)
            $0.top.equalTo(rightSeekView.snp.top).offset(5)
            $0.height.equalTo(50)
            $0.width.equalTo(50)
        }

        leftSeekView.addSubview(prevVideoButton)
        prevVideoButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(17)
            $0.width.equalTo(50)
            $0.height.equalTo(50)

        }

    }

    private func showVideo() {
        VideoLauncher.playerLayer = AVPlayerLayer(player: VideoLauncher.player)

        self.videoPlayView.layer.addSublayer(VideoLauncher.playerLayer!)

        self.view.addSubview(videoPlayView)
        videoPlayView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top)
            $0.leading.equalTo(view.snp.leading)
            $0.trailing.equalTo(view.snp.trailing)
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

    private func getProgressTime() {
        if VideoLauncher.currentSecond > 0 {
            let secondsString = String(format: "%02d", Int(VideoLauncher.currentSecond) % 60)
            let minString = String(format: "%02d", Int(VideoLauncher.currentSecond)/60)
            if let duration = VideoLauncher.player?.currentItem!.asset.duration {
                let durationSeconds = CMTimeGetSeconds(duration)
                self.videoSlider.value = Float(VideoLauncher.currentSecond / durationSeconds)
            }
            self.currentTimeLabel.text = "\(minString):\(secondsString)"
        }
        let interval = CMTime(value: 1, timescale: 2)
        VideoLauncher.player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { progress in
            let seconds = CMTimeGetSeconds(progress)
            VideoLauncher.currentSecond = seconds
            let secondsString = String(format: "%02d", Int(seconds) % 60)
            let minString = String(format: "%02d", Int(seconds)/60)
            self.currentTimeLabel.text = "\(minString):\(secondsString)"


            if let duration = VideoLauncher.player?.currentItem!.asset.duration {
                let durationSeconds = CMTimeGetSeconds(duration)
                self.videoSlider.value = Float(seconds / durationSeconds)
            }
        })
    }

    private func getTime() {
        if VideoLauncher.player != nil {
            if VideoLauncher.currentPlayindex != index {
                videoLengthLabel.text = "00:00"
            } else {
                let seconds = CMTimeGetSeconds((VideoLauncher.player?.currentItem!.asset.duration)!)
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
                getProgressTime()
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
            cell.backgroundColor = UIColor.colorSwitch
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

extension VideoViewController: AVPictureInPictureControllerDelegate {
    func pictureInPictureControllerWillStartPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        print("Start")
    }
    func pictureInPictureControllerDidStartPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        print("Started")
    }
    func pictureInPictureController(_ pictureInPictureController: AVPictureInPictureController, failedToStartPictureInPictureWithError error: Error) {
        print("failToStart")
    }
    func pictureInPictureControllerWillStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        print("will Start")
    }
    func pictureInPictureControllerDidStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        print("Stopped")
    }
    func pictureInPictureController(_ pictureInPictureController: AVPictureInPictureController, restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
        print("restore user Interface before stop")
    }
}
