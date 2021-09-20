//
//  UserViewController.swift
//  Practice1
//
//  Created by ITlearning on 2021/09/16.
//

import UIKit
import SnapKit

class UserViewController: UIViewController {
    
    //var tabCollectionView = UICollectionView()
    let cellId = "cellId"
    
    
    // MARK: - 뷰가 나오기 전 액션
    override func viewWillAppear(_ animated: Bool) {
        uploadLabel.text = "\(feedArray.count) \n 게시물"
        tabBar.selectedItem = tabBar.items?.first
        collectionView.reloadData()
    }
    
    let scrollView: UIScrollView = {
       
        let scroll = UIScrollView()
        scroll.bounces = true
        scroll.isPagingEnabled = false
        
        
        return scroll
    }()
    
    
    let colorView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 1000))
        view.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        
        return view
    }()
    
    let userViewTitle: UILabel = {
        let label = UILabel()
        label.text = "IBY"
        label.font = UIFont.boldSystemFont(ofSize: 23)
        
        return label
    }()
    
    // MARK: - 첫 줄 스택 뷰
    // 유저 대문짝 사진
    let userImage: UIImageView = {
        
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
    let uploadLabel: UILabel = {
        let label = UILabel()
        label.text = " 10 \n 게시물  "
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    // 팔로워 명수 라벨
    let followLabel: UILabel = {
        let label = UILabel()
        label.text = " 10 \n 팔로워  "
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    // 팔로잉 명수 라벨
    let followingLabel: UILabel = {
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
        let stackView = UIStackView(arrangedSubviews: [uploadLabel, followLabel, followingLabel])
        stackView.axis = .horizontal
        stackView.spacing = 30
        
        return stackView
    }()
    
    // MARK: - 두 번째 스택 뷰
    
    // 계정 이름 말고 실제 이름 라벨
    let name: UILabel = {
        
        let label = UILabel()
        label.text = "인병윤"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    // 상태 메시지
    let statusMessage: UILabel = {
        let label = UILabel()
        label.text = "인스타그램 클론 합니다."
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()
    
    // 두번째 스택 뷰
    lazy var nameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [name, statusMessage])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        
        return stackView
    }()
    
    
    // MARK: - 중간 프로필 편집 버튼
    let profileEditButton: UIButton = {
        let button = UIButton()
        button.setTitle("프로필 편집", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(editBtnClick), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)

        button.layer.cornerRadius = 3
        button.layer.borderWidth = 0.5
        button.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return button
    }()
    
    @objc func editBtnClick() {
        let alert = UIAlertController(title: "프로필 편집", message: "버튼이 눌렸습니다.", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "닫기", style: .default, handler: nil)
        
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    let collectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .init(x: 0, y: 0, width: 100, height: 800), collectionViewLayout: flowLayout)
        //collectionView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return collectionView
        
    }()
    
    // MARK: - ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tabBar.delegate = self
        scrollView.delegate = self
        scrollView.contentInset.top = tabBar.frame.height
        
        collectionViewSetting()
        settingUI()
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

        tab.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tab.layer.borderWidth = 0
        tab.barTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tab.barStyle = .default
        let button = UIButton()
        
        
        
        tab.items = [grid,tag]
        
        return tab
       }()

    // MARK: - UI 세팅
    func settingUI() {
        // UserView 타이틀(아이디)
        view.addSubview(userViewTitle)
        userViewTitle.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.equalTo(20)
        }
        // MARK: - 스크롤 뷰에 들어가는 UI들
        
        // 유저 사진
        scrollView.addSubview(userImage)
        userImage.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top).offset(10)
            $0.leading.equalTo(scrollView.snp.leading).offset(18)
            $0.width.equalTo(80)
            $0.height.equalTo(80)
        }
        
        // 유저 게시물, 팔로워, 팔로잉 수
        scrollView.addSubview(userStackView)
        userStackView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top).offset(30)
            $0.leading.equalTo(userImage.snp.trailing).offset(30)
        }
        
        // 실제 이름 표시 라벨
        scrollView.addSubview(nameStackView)
        nameStackView.snp.makeConstraints {
            $0.top.equalTo(userImage.snp.bottom).offset(15)
            $0.leading.equalTo(scrollView.snp.leading).offset(20)
            //$0.bottom.equalTo(-20)
        }
        
        
        // 프로필 편집 버튼
        scrollView.addSubview(profileEditButton)
        profileEditButton.snp.makeConstraints {
            $0.top.equalTo(nameStackView.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(scrollView.snp.leading).offset(15)
            $0.trailing.equalTo(scrollView.snp.trailing).offset(-15)
            $0.height.equalTo(30)
            $0.width.equalTo(300)

        }
        
        
        // 탭 바
        scrollView.addSubview(tabBar)
        tabBar.snp.makeConstraints {
            $0.top.equalTo(profileEditButton.snp.bottom).offset(15)
            $0.leading.equalTo(scrollView.snp.leading)
            $0.trailing.equalTo(scrollView.snp.trailing).offset(0)
            $0.width.equalTo(scrollView.snp.width)
            //$0.bottom.equalTo()
        }
        
        
        // 이 뷰를 추가했을 때는, 탭바가 고정이 되긴함.
        // 근데 문제는, 고정만 되고, 사진이 여러개 추가될 시에는 더 내려가지가 않는다.
        /*
        scrollView.addSubview(colorView)
        
        colorView.snp.makeConstraints {
            $0.top.equalTo(tabBar.snp.bottom).offset(15)
            $0.leading.equalTo(scrollView.snp.leading).offset(15)
            $0.trailing.equalTo(scrollView.snp.trailing).offset(-15)
            $0.bottom.equalTo(scrollView.snp.bottom)
            $0.height.equalTo(400)
        }
        */
        
        scrollView.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(tabBar.snp.bottom)
            $0.leading.equalTo(scrollView.snp.leading)
            $0.trailing.equalTo(scrollView.snp.trailing)
            $0.bottom.equalTo(scrollView.snp.bottom).offset(618)
        }
        
        // 전체 스크롤 뷰
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(userViewTitle.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            
        }
        
        
    }
    
}

// MARK: - 중간 탭 바 익스텐션
extension UserViewController: UITabBarDelegate {
    
    // 현재 선택된 탭바 아이템 확인 메서드
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.title == "People" {
            let alert = UIAlertController(title: "태그", message: "준비중입니다.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "닫기", style: .cancel, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
            tabBar.selectedItem = tabBar.items?.first
        }
    }
}

// MARK: - 스크롤링 익스텐션
// 아직 탭바 고정과 컬렉션 뷰와 같이 올라가는 뷰 구현 못함
extension UserViewController: UIScrollViewDelegate {
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print(tabBar.frame.maxY)
        let endY = scrollView.contentSize.height
        print(endY)
        let y = -scrollView.contentOffset.y
        print(y)
        
        userImage.snp.remakeConstraints {
            $0.top.equalTo(y)
            $0.leading.equalTo(20)
            $0.height.equalTo(80)
            $0.width.equalTo(80)
        }
        
        userStackView.snp.remakeConstraints {
            $0.top.equalTo(y)
            $0.leading.equalTo(userImage.snp.trailing).offset(30)
        }
        
        
    }
}

// MARK: - 컬렉션 뷰 익스텐션
extension UserViewController: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    // 컬렉션뷰 셀의 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedArray.count
    }
    
    // 컬렉션뷰 셀에서 보여줄 것 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.cellId, for: indexPath) as! FeedCollectionViewCell
        
        cell.imageView.image = feedArray[indexPath.row].uploadImage
        
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
