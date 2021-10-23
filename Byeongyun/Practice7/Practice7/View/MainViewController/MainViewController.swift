//
//  ViewController.swift
//  Practice7
//
//  Created by ITlearning on 2021/10/20.
//

import UIKit
import SnapKit
import AVFoundation

class MainViewController: UIViewController, MainViewProtocol {

    override var prefersStatusBarHidden: Bool {
        return false
    }

    private var launcher: VideoLauncher = VideoLauncher()
    private let youtubeTitle: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.image = UIImage(named: "YouTube-Logo")
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return imageView
    }()

    private let miniView: UIView = {
        let miniView = UIView()
        return miniView
    }()

    @objc
    func touchAction(sender: UITapGestureRecognizer) {
        inToVideoView(index: VideoLauncher.currentPlayindex)
    }

    private let miniViewCancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.imageView?.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(cancelMiniView), for: .touchUpInside)
        button.sizeToFit()
        return button
    }()

    @objc
    func cancelMiniView() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.miniView.transform = CGAffineTransform(translationX: 0, y: 100)

        }, completion: { _ in
            self.miniView.isHidden = true
            VideoLauncher.player?.pause()
            VideoLauncher.player = nil
        })
    }

    private let videoMiniView: UIView = {
        let videoMV = UIView()
        videoMV.backgroundColor = .black

        return videoMV
    }()

    private var miniViewVideoNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)

        return label
    }()

    private var miniViewVideoChannelNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .systemGray

        return label
    }()

    private lazy var miniStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [miniViewVideoNameLabel, miniViewVideoChannelNameLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8

        return stackView
    }()

    private let mainTableView = UITableView()

    private var presenter: MainPresenterProtocol!

    init() {
        super.init(nibName: nil, bundle: nil)
        presenter = MainPresenter(view: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter.fetchVideoList()
        NotificationCenter.default.addObserver(self, selector: #selector(disMissView(_:)), name: NSNotification.Name("dismiss"), object: nil)
        configureNavigationBar()
        configureLayout()
        //configureMiniLayout()
        configureTableView()
    }

    @objc
    func disMissView(_ notification: Notification) {
        miniViewVideoNameLabel.text = presenter.getVideoList()[VideoLauncher.currentPlayindex].videoMainLabel
        miniViewVideoChannelNameLabel.text = presenter.getVideoList()[VideoLauncher.currentPlayindex].channelName
        configureMiniLayout()

    }

    private func configureTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.cellId)
    }

    private func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.setLeftBarButton(UIBarButtonItem.init(customView: youtubeTitle), animated: true)
    }

    private func configureLayout() {
        view.addSubview(mainTableView)
        mainTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        miniView.frame = CGRect(x: 0, y: 0, width: view.frame.width - 30, height: 150)
        miniView.backgroundColor = .white
        miniView.alpha = 0.9
        view.addSubview(miniView)
        miniView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(60)
            $0.width.equalTo(view.frame.width)
        }

        miniView.addSubview(miniViewCancelButton)
        miniViewCancelButton.snp.makeConstraints {
            $0.centerY.equalTo(miniView.snp.centerY)
            $0.trailing.equalTo(miniView.snp.trailing).offset(-20)
            $0.height.equalTo(50)
            $0.width.equalTo(50)
        }
        miniView.addSubview(videoMiniView)
        videoMiniView.snp.makeConstraints {
            $0.centerY.equalTo(miniView.snp.centerY)
            $0.leading.equalTo(miniView.snp.leading).offset(10)
            $0.height.equalTo(50)
            $0.width.equalTo(50)
        }
        miniView.addSubview(miniStackView)
        miniStackView.snp.makeConstraints {
            $0.centerY.equalTo(miniView.snp.centerY)
            $0.leading.equalTo(videoMiniView.snp.trailing).offset(10)
        }
        //videoMiniView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        miniView.isHidden = true
        let touch = UITapGestureRecognizer(target: self, action: #selector(touchAction(sender:)))
        miniView.addGestureRecognizer(touch)
        view.bringSubviewToFront(miniView)
    }

    func configureMiniLayout() {
        miniView.isHidden = false
        videoMiniView.layer.addSublayer(VideoLauncher.playerLayer!)
        VideoLauncher.playerLayer?.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        videoMiniView.alpha = 1.0
    }
    func updateTableView() {
        mainTableView.reloadData()
    }

    func inToVideoView(index: Int) {
        let videoViewController = VideoViewController(index)
        videoViewController.modalPresentationStyle = .overCurrentContext
        present(videoViewController, animated: true, completion: {
            self.miniView.isHidden = false
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                print("여기")
                self.miniView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.miniView.alpha = 0.9
            }, completion: nil)
        })
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getVideoList().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.cellId, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        cell.configureUI(model: presenter.getVideoList()[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        inToVideoView(index: indexPath.row)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}
