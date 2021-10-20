//
//  ViewController.swift
//  Practice7
//
//  Created by ITlearning on 2021/10/20.
//

import UIKit
import SnapKit

class MainViewController: UIViewController, MainViewProtocol {

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
            self.miniView.removeFromSuperview()
        })
    }

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
        configureNavigationBar()
        configureLayout()
        configureTableView()
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

        view.bringSubviewToFront(miniView)
    }

    func updateTableView() {
        mainTableView.reloadData()
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
        let videoViewController = VideoViewController()
        videoViewController.modalPresentationStyle = .overCurrentContext
        present(videoViewController, animated: true, completion: nil)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}
