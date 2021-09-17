//
//  UserViewController.swift
//  Practice1
//
//  Created by ITlearning on 2021/09/16.
//

import UIKit

class UserViewController: UIViewController {
    
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
        imageView.layer.borderWidth = 1
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
        stackView.spacing = 15
        
        return stackView
    }()
    
    // MARK: - 두 번째 스택 뷰
    
    // 계정 이름 말고 실제 이름 라벨
    let name: UILabel = {
        
        let label = UILabel()
        label.text = "인병윤"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    // 상태 메시지
    let statusMessage: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    // 두번째 스택 뷰
    lazy var nameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [name, statusMessage])
        stackView.axis = .vertical
        stackView.alignment = .leading
        
        return stackView
    }()
    
    
    // MARK: - 중간 프로필 편집 버튼
    let profileEditButton: UIButton = {
        let button = UIButton()
        button.setTitle("프로필 편집", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return button
    }()
    
    // MARK: - 중 하단 탭 바
    /*
    let tabBar : UITabBarController = {
        
    }()
    */
    
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
        
        view.addSubview(userImage)
        userImage.snp.makeConstraints {
            $0.top.equalTo(userViewTitle.snp.bottom).offset(20)
            $0.leading.equalTo(20)
            $0.height.equalTo(100)
            $0.width.equalTo(100)
            
        }
        
        view.addSubview(userStackView)
        userStackView.snp.makeConstraints {
            $0.top.equalTo(userViewTitle.snp.bottom).offset(50)
            $0.leading.equalTo(userImage.snp.trailing).offset(30)
        }
        
        view.addSubview(name)
        name.snp.makeConstraints {
            $0.top.equalTo(userImage.snp.bottom).offset(10)
            $0.leading.equalTo(userImage.snp.leading)
        }
    }
    

}
