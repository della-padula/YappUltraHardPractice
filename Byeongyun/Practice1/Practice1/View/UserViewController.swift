//
//  UserViewController.swift
//  Practice1
//
//  Created by ITlearning on 2021/09/16.
//

import UIKit
import SnapKit

class UserViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        uploadLabel.text = "\(feedArray.count) \n 게시물"
    }
    
    let scrollView: UIScrollView = {
       
        let scroll = UIScrollView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
        scroll.contentSize = CGSize(width: scroll.frame.size.width, height: 1000)
        scroll.bounces = true
        scroll.isPagingEnabled = false
        
        
        return scroll
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
        //button.sizeThatFits(CGSize(width: 30, height: 300))
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
    
    // MARK: - 중 하단 탭 바
    
    let tabBar : UITabBarController = {
        let bar = UITabBarController()
        bar.setViewControllers(<#T##viewControllers: [UIViewController]?##[UIViewController]?#>, animated: <#T##Bool#>)
    }()
    
    
    //let barButton = UIBarButtonItem
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        settingUI()
    }
    
    
    

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
        }
        
        // 프로필 편집 버튼
        scrollView.addSubview(profileEditButton)
        profileEditButton.snp.makeConstraints {
            $0.top.equalTo(nameStackView.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(scrollView.snp.leading).offset(15)
            $0.trailing.equalTo(scrollView.snp.trailing).offset(15)
            $0.height.equalTo(30)
            $0.width.equalTo(300)
            
            
            
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
