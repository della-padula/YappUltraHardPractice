//
//  ViewController.swift
//  Practice3
//
//  Created by ITlearning on 2021/10/02.
//

import UIKit
import SnapKit
class MainViewController: UIViewController {
    
    private var mainViewCell: MainCollectionViewCell?
    private var isStatusBarHidden = false
    private var collectionIndex: IndexPath?
    private let transition = Transition()
    let cellId = "MainCell"
    var imageFrame = CGRect.zero
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "MONDAY 4 OCTOBER"
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = .systemGray
        return label
    }()
    
    private let toDayTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Today"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dayLabel, toDayTextLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        return stackView
    }()
    
    private let mainCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 80, left: 10, bottom: 80, right: 10)
        
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width-50, height: 400)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private let tabBar: UITabBar = {
        let tab = UITabBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        let today = UITabBarItem(title: "Today", image: UIImage(systemName: "square.stack.3d.up.fill"), selectedImage: UIImage(systemName: "square.stack.3d.up.fill"))
        let games = UITabBarItem(title: "Games", image: UIImage(systemName: "gamecontroller"), selectedImage: UIImage(systemName: "gamecontroller"))
        let apps = UITabBarItem(title: "Apps", image: UIImage(systemName: "square.filled.on.square"), selectedImage: UIImage(systemName: "square.filled.on.square"))
        let arcade = UITabBarItem(title: "Arcade", image: UIImage(systemName: "dpad.fill"), selectedImage: UIImage(systemName: "dpad.fill"))
        let search = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        tab.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tab.barStyle = .default
        tab.items = [today, games, arcade, search]
        tab.selectedItem = tab.items?.first
        return tab
    }()
    private var presenter: Presenter!
    
    init(with presenter: Presenter) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = presenter.backgroundColor
        NotificationCenter.default.addObserver(self, selector: #selector(mainShow), name: NSNotification.Name(rawValue: "MainShow"), object: nil)
        configureUI()
        configureCollectionView()
    }
    
    @objc
    func mainShow() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func configureCollectionView() {
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        presenter.registerCells(for: mainCollectionView, num: 1)
        
    }
    
    private func configureUI() {
        view.addSubview(mainCollectionView)
        mainCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
        }
        
        mainCollectionView.addSubview(mainStackView)
        mainStackView.snp.makeConstraints {
            $0.top.equalTo(mainCollectionView.snp.top).offset(10)
            $0.leading.equalTo(mainCollectionView.snp.leading).offset(30)
        }
        
        view.addSubview(tabBar)
        tabBar.snp.makeConstraints {
            $0.top.equalTo(mainCollectionView.snp.bottom)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIViewControllerTransitioningDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let model = Model()
        return model.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        let model = Model()
        
        cell.cellMainImage = model.images[indexPath.row]
        cell.cellMainString = model.mainTitles[indexPath.row]
        cell.cellSubString = model.subTitles[indexPath.row]
        //cell.cellExplainAppString = explainString
        transition.destinationFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * self.view.frame.width / UIScreen.main.bounds.width)
 //CGRect(x: 0, y: 0, width: view.frame.width, height: 400)
        print("transition.destinationFrame \(transition.destinationFrame)")
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 35
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionIndex = indexPath
        if let cell = collectionView.cellForItem(at: indexPath) as? MainCollectionViewCell {
            let a = collectionView.convert(cell.frame, to: collectionView.superview)
            
            transition.startingFrame = CGRect(x: a.minX, y: a.minY, width:cell.frame.width, height: 400) //CGRect(x: a.minX, y: a.min, width: UIScreen.main.bounds.width-50, height: 400)
            let image = presenter.loadImage(index: indexPath.row)
            let mainTitle = presenter.loadMainString(index: indexPath.row)
            let subTitle = presenter.loadSubString(index: indexPath.row)
            let detail = DetailViewController(image: image, mainText: mainTitle, subText: subTitle)
            detail.transitioningDelegate = self
            detail.modalPresentationStyle = .custom
            
            self.present(detail, animated: true, completion: nil)
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        return transition
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.3) {
            cell?.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.3) {
            cell?.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
}
