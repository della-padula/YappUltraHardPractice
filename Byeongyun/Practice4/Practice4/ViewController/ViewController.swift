//
//  ViewController.swift
//  Practice4
//
//  Created by ITlearning on 2021/10/06.
//

import UIKit
import AVFoundation
import MediaPlayer

class ViewController: UIViewController {
    private var model: Model?
    private var musicPlayer : AVAudioPlayer?
    private var timer: Timer?
    private var presenter: Presenter?
    private var lyricDic: Dictionary<Double, String> = [:]
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "Day6")
        return imageView
    }()
    
    private let controllButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.tintColor = .systemTeal
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    @objc
    func buttonAction() {
        controllButton.isSelected = !controllButton.isSelected
        if controllButton.isSelected {
            controllButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            if let time = timer {
                if time.isValid {
                    configuerTimer()
                }
            }
            musicPlayer?.play()
        } else {
            controllButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            musicPlayer?.pause()
        }
    }
    
    private let musicNameLabel: UILabel = {
        let label = UILabel()
        label.text = "행복했던 날들이었다"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        return label
    }()
    
    private let musicSingerLabel: UILabel = {
        let label = UILabel()
        label.text = "Day6"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var musicStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [musicNameLabel, musicSingerLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        return stackView
    }()
    
    private var musicSlider: UISlider = {
        let slider = CustomSlider()
        slider.addTarget(self, action: #selector(sliderAction(_:)), for: .valueChanged)
        slider.minimumTrackTintColor = .systemTeal
        return slider
    }()
    
    private var lyricMainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private var lyricSubLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .systemGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    @objc
    func sliderAction(_ sender: UISlider) {
        if musicSlider.isTracking { return }
        musicSlider.isContinuous = true
        musicPlayer?.currentTime = TimeInterval(sender.value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureBlur()
        configureUI()
        initPlayer()
        configuerTimer()
        infoCenter()
        remoteCenter()
        guard let numbers = presenter?.parseLyrics() else { return }
        lyricDic = numbers
    }
    
    init(with presenter: Presenter) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureBlur() {
        backgroundImageView.image = presenter?.loadBackgound()
        let blur = UIBlurEffect(style: .regular)
        let visualEffectView = UIVisualEffectView(effect: blur)
        visualEffectView.frame = view.frame
        backgroundImageView.addSubview(visualEffectView)
    }
    
    private func infoCenter() {
        
        UIApplication.shared.beginReceivingRemoteControlEvents()
        let center = MPRemoteCommandCenter.shared()
        
        // Seek 기능 활성화
        center.changePlaybackPositionCommand.addTarget { event -> MPRemoteCommandHandlerStatus in
            if let positionTime = (event as? MPChangePlaybackPositionCommandEvent)?.positionTime {
                self.musicPlayer?.currentTime = positionTime
                if let currentTime = self.musicPlayer?.currentTime {
                    self.musicSlider.value = Float(currentTime)
                }
                self.remoteCenter()
            }
            return .success
        }
        
        // 음악 시작 버튼 활성화
        center.playCommand.isEnabled = true
        center.playCommand.addTarget { [unowned self] event in
            if let isPlaying = musicPlayer?.isPlaying {
                if !isPlaying {
                    self.musicPlayer?.play()
                    self.controllButton.isSelected = !self.controllButton.isSelected
                    return .success
                }
            }
            return .commandFailed
        }
        
        // 음악 일시정지 버튼 활성화
        center.pauseCommand.isEnabled = true
        center.pauseCommand.addTarget { [unowned self] event in
            if let isPlaying = musicPlayer?.isPlaying {
                if isPlaying {
                    self.musicPlayer?.pause()
                    self.controllButton.isSelected = !self.controllButton.isSelected
                }
                return .success
            }
            return .commandFailed
        }
    }
    
    private func remoteCenter() {
        
        let center = MPNowPlayingInfoCenter.default()
        var nowPlayingInfo = center.nowPlayingInfo ?? [String: Any]()
        
        nowPlayingInfo[MPMediaItemPropertyTitle] = "행복했던 날들이었다"
        nowPlayingInfo[MPMediaItemPropertyArtist] = "Day6"
        if let albumCover = presenter?.loadCoverImage() {
            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: albumCover.size, requestHandler: { size in
                return albumCover
            })
        }
        
        // 총 길이
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = musicPlayer?.duration
        // 재생 시간에 따른 프로그래스 바 초기화
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = musicPlayer?.rate
        // 현재 재생시간
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = musicPlayer?.currentTime
        
        center.nowPlayingInfo = nowPlayingInfo
        
    }
    
    private func initPlayer() {
        
        guard let soundAsset: NSDataAsset = presenter?.loadSong() else { return }
        do {
            try musicPlayer = AVAudioPlayer(data: soundAsset.data)
            musicPlayer?.delegate = self
        } catch let error as NSError {
            print("플레이어 초기화 실패")
            print("\(error)")
        }
        
        musicSlider.minimumValue = 0
        guard let duration = musicPlayer?.duration else { return }
        guard let currentTime = musicPlayer?.currentTime else { return }
        musicSlider.maximumValue = Float(duration)
        musicSlider.value = Float(currentTime)
    }
    
    private func configuerTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [self] _ in
            if self.musicSlider.isTracking { return }
            guard let currentTime = self.musicPlayer?.currentTime else { return }
            if self.lyricDic[round(currentTime * 100) / 100] != nil {
                updateLyric(round(currentTime * 100) / 100)
            }
            
            self.musicSlider.value = Float(currentTime)
        })
        
        timer?.fire()
    }
    
    private func updateLyric(_ time: Double) {
        if let index = presenter?.loadLyricTimeArray(time) {
            lyricMainLabel.text = presenter?.loadLyricArray(index)
            guard let count = presenter?.lyricTimeArrayCount() else { return }
            if index == count-1 {
                lyricMainLabel.text = presenter?.loadLyricArray(index)
                lyricSubLabel.text = ""
            } else {
                lyricMainLabel.text = presenter?.loadLyricArray(index)
                lyricSubLabel.text = presenter?.loadLyricArray(index+1)
            }
        }
    }
    
    private func configureUI() {
        
        let sliderHeight = view.frame.height
        let padding = sliderHeight * 0.06
        
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(albumCoverImageView)
        albumCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        albumCoverImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        albumCoverImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        albumCoverImageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7).isActive = true
        albumCoverImageView.heightAnchor.constraint(equalTo: albumCoverImageView.widthAnchor).isActive = true
        
        view.addSubview(musicStackView)
        musicStackView.translatesAutoresizingMaskIntoConstraints = false
        musicStackView.topAnchor.constraint(equalTo: albumCoverImageView.bottomAnchor, constant: 20).isActive = true
        musicStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        view.addSubview(musicSlider)
        musicSlider.translatesAutoresizingMaskIntoConstraints = false
        musicSlider.topAnchor.constraint(equalTo: musicStackView.bottomAnchor, constant: 20).isActive = true
        musicSlider.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        musicSlider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        musicSlider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        view.addSubview(lyricMainLabel)
        lyricMainLabel.translatesAutoresizingMaskIntoConstraints = false
        lyricMainLabel.topAnchor.constraint(equalTo: musicSlider.bottomAnchor, constant: 15).isActive = true
        lyricMainLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        lyricMainLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        
        view.addSubview(controllButton)
        controllButton.translatesAutoresizingMaskIntoConstraints = false
        controllButton.topAnchor.constraint(equalTo: lyricMainLabel.bottomAnchor, constant: padding).isActive = true
        controllButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        controllButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        controllButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(lyricSubLabel)
        lyricSubLabel.translatesAutoresizingMaskIntoConstraints = false
        lyricSubLabel.topAnchor.constraint(equalTo: lyricMainLabel.bottomAnchor, constant: 5).isActive = true
        lyricSubLabel.bottomAnchor.constraint(equalTo: controllButton.topAnchor, constant: -10).isActive = true
        lyricSubLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        lyricSubLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
    }

}

extension ViewController: AVAudioPlayerDelegate {
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        guard let error: Error = error else {
            print("플레이어 오류 발생")
            return
        }
        
        let errorMessage: String
        errorMessage = "오류 발생 \(error.localizedDescription)"
        
        let alert = UIAlertController(title: "알림", message: errorMessage, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        controllButton.isSelected = false
        musicSlider.value = 0
        timer?.invalidate()
        timer = nil
        lyricMainLabel.text = ""
        lyricSubLabel.text = ""
        remoteCenter()
    }
}

