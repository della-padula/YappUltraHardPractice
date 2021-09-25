//
//  UserViewController.swift
//  Practice1
//  유저 뷰 컨트롤러
//  Created by ITlearning on 2021/09/16.
//

import UIKit
import SnapKit
class UserViewController: UIViewController {
    let minHeight: CGFloat = -300
    let stopHeight : CGFloat = -50
    private var feedContacts: [FeedArray] = []
    
    // MARK: - 뷰가 나오기 전 액션
    override func viewWillAppear(_ animated: Bool) {
        uploadLabel.text = "\(feedContacts.count) \n 게시물"
        tabBar.selectedItem = tabBar.items?.first
        readFeedContacts()
    }
    
    // MARK: - 뼈대 뷰 선언과 메인 타이틀 선언
    // 타이틀 뷰
    private let titleView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()
    // 유저 뷰
    private let userView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()
    // 타이틀 뷰에 입력될 계정
    private let userViewTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "IBY"
        label.font = UIFont.boldSystemFont(ofSize: 23)
        return label
    }()
    // MARK: - 첫 줄 스택 뷰
    // 유저 프로필 사진
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "user")
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
        
    }()
    // 업로드 개수 라벨
    private let uploadLabel: UILabel = {
        let label = UILabel()
        label.text = " 10 \n 게시물  "
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    // 팔로워 명수 라벨
    private let followerLabel: UILabel = {
        let label = UILabel()
        label.text = " 10 \n 팔로워  "
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    // 팔로잉 명수 라벨
    private let followingLabel: UILabel = {
        let label = UILabel()
        label.text = " 10 \n 팔로잉  "
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    // 첫 스택 뷰
    // stackView를 구성할 때 lazy를 사용하는 이유?
    // 기본적으로 일반 변수들은 클래스가 생성된 이후에 접근이 가능하기 때문에 클래스 내의 다른 영역(메서드, 프로퍼티) 에서는
    // self를 통해 접근할 수 없지만 lazy 키워드가 붙으면 생성 후 추후에
    // 접근할 것이라는 의미이기 때문에 class 내에서 self로 접근이 가능하다.
    lazy var userStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [uploadLabel, followerLabel, followingLabel])
        stackView.axis = .horizontal
        stackView.spacing = 30
        return stackView
    }()
    // MARK: - 두 번째 스택 뷰
    // 계정 이름 말고 실제 이름 라벨
    private let realNameLabel: UILabel = {
        let label = UILabel()
        label.text = "인병윤"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    // 상태 메시지
    private let statusMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "인스타그램 클론 합니다."
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()
    // 두번째 스택 뷰
    lazy var nameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [realNameLabel, statusMessageLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        return stackView
    }()
    // MARK: - 중간 프로필 편집 버튼
    private let profileEditButton: UIButton = {
        let button = UIButton()
        button.setTitle("프로필 편집", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(editButtonClickAction), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.layer.cornerRadius = 3
        button.layer.borderWidth = 0.5
        button.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return button
    }()
    @objc
    func editButtonClickAction() {
        let alert = UIAlertController(title: "프로필 편집", message: "버튼이 눌렸습니다.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "닫기", style: .default, handler: nil)
        
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - 컬렉션 뷰 선언
    let collectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .init(x: 0, y: 0, width: 100, height: 1500), collectionViewLayout: flowLayout)
        collectionView.contentInset = UIEdgeInsets(top: 250, left: 0, bottom: 0, right: 0)
        return collectionView
    }()
    
    // MARK: - ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tabBar.delegate = self
        collectionViewSetting()
        settingUI()
        readFeedContacts()
    }
    
    private func readFeedContacts() {
        let oldcount = feedContacts.count
        
        feedContacts = CoreDataWorker.shared.read()
        
        if oldcount < feedContacts.count {
            collectionView.reloadData()
        }
    }
    
    // MARK: - 컬렉션 뷰 세팅
    func collectionViewSetting() {
        collectionView.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: FeedCollectionViewCell.cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    // MARK: - 탭바 선언
    let tabBar : UITabBar = {
        let tab = UITabBar(frame: CGRect(x: 0, y: 0, width: 500, height: 30))
        let grid = UITabBarItem(title: "Feed", image: UIImage(systemName: "squareshape.split.3x3"), selectedImage: UIImage(systemName: "squareshape.split.3x3"))
        let tag = UITabBarItem(title: "People", image: UIImage(systemName: "person.crop.square"), selectedImage: UIImage(systemName: "person.crop.square"))
        let button = UIButton()
        tab.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tab.layer.borderWidth = 0
        tab.barTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tab.barStyle = .default
        tab.items = [grid,tag]
        return tab
       }()
    
    // MARK: - UI 세팅
    func settingUI() {
        // UserView 타이틀(아이디)
        titleView.addSubview(userViewTitleLabel)
        userViewTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.top).offset(50)
            $0.leading.equalTo(20)
        }
        // 타이틀 뷰 추가
        view.addSubview(titleView)
        titleView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-50)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.height.equalTo(100)
        }
        // 컬렉션 뷰 추가
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom)
            $0.leading.equalTo(view.snp.leading)
            $0.trailing.equalTo(view.snp.trailing)
            $0.bottom.equalTo(view.snp.bottom)
        }
        // 유저 뷰 추가(위에 사진이나, 팔로잉, 등등 쓰여져 있는 부분)
        // 사진이 표시되는 컬렉션 뷰 빼고는 다 이 유저 뷰이다.
        view.addSubview(userView)
        userView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom)
            $0.leading.equalTo(view.snp.leading)
            $0.trailing.equalTo(view.snp.trailing)
            $0.height.equalTo(250)
        }
        // 유저 뷰 - 유저 이미지 추가
        userView.addSubview(userImageView)
        userImageView.snp.makeConstraints {
            $0.top.equalTo(userView.snp.top).offset(10)
            $0.leading.equalTo(userView.snp.leading).offset(15)
            $0.width.equalTo(80)
            $0.height.equalTo(80)
        }
        // 유저 뷰 - 유저 게시글, 팔로우,팔로잉 수 추가
        userView.addSubview(userStackView)
        userStackView.snp.makeConstraints {
            $0.top.equalTo(userView.snp.top).offset(30)
            $0.leading.equalTo(userImageView.snp.trailing).offset(30)
        }
        // 유저 뷰 - 유저 실제 이름과 상태메시지 라벨 추가
        userView.addSubview(nameStackView)
        nameStackView.snp.makeConstraints {
            $0.top.equalTo(userImageView.snp.bottom).offset(15)
            $0.leading.equalTo(userView.snp.leading).offset(20)
        }
        // 유저 뷰 - 프로필 편집 버튼 추가
        userView.addSubview(profileEditButton)
        profileEditButton.snp.makeConstraints {
            $0.top.equalTo(nameStackView.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(userView.snp.leading).offset(15)
            $0.height.equalTo(30)
        }
        // 유저 뷰 - 탭 바 추가
        userView.addSubview(tabBar)
        tabBar.snp.makeConstraints {
            $0.top.equalTo(profileEditButton.snp.bottom).offset(16)
            $0.leading.equalTo(userView.snp.leading)
            $0.width.equalTo(userView.snp.width)
        }
        // 가장 위 뷰로 타이틀(계정) 뷰를 올려놓음
        self.view.bringSubviewToFront(titleView)
    }

}

// MARK: - 중간 탭 바 익스텐션
extension UserViewController: UITabBarDelegate {
    // 현재 선택된 탭바 아이템 확인 메서드
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.title == "People" {
            let alert = UIAlertController(title: "태그", message: "준비중입니다.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "닫기", style: .cancel, handler: nil)
            tabBar.selectedItem = tabBar.items?.first
            
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
            
        }
    }
}

// MARK: - 스크롤링 익스텐션
extension UserViewController: UIScrollViewDelegate {
    // 스크롤 시 현재 움직이는 좌표를 볼 수 있는 메서드
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.showsLargeContentViewer = false
        // 아직 숫자에 의존적인 UI 컨트롤이다.
        // 추후에 능동적으로 움직이는 UI를 구현해보겠다.
        if scrollView.contentOffset.y < -50 {
            userView.frame.origin.y = max(abs(scrollView.contentOffset.y), minHeight)-150
        } else {
            userView.frame.origin.y = minHeight+200
        }
    }
}

// MARK: - 컬렉션 뷰 익스텐션
extension UserViewController: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    // 컬렉션뷰 셀의 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedContacts.count
    }
    // 컬렉션뷰 셀에서 보여줄 것 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.cellId, for: indexPath) as! FeedCollectionViewCell
        cell.cellDataSetting = feedContacts[indexPath.row]
        
        return cell
    }
    // 컬렉션뷰 셀 크기와 한 줄에 보여줄 개수 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 1, left: 3, bottom: 3, right: 3)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.invalidateLayout()
        return CGSize(width: (self.view.frame.width/3)-3, height: (self.view.frame.width/3)-3)
    }
}
