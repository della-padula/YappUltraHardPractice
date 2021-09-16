//
//  PlusViewController.swift
//  Practice1
//
//  Created by ITlearning on 2021/09/16.
//

import UIKit
import SnapKit

class PlusViewController: UIViewController {

    let mainVC = MainViewController()
    
    // MARK: - 버튼 선언 공간
    
    // 취소버튼
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        
        return button
    }()
    
    // 저장버튼
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(save), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - 버튼 액션 구현 공간
    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func save() {
        let num : Int = Int(arc4random() % 100)
        mainVC.feed.append(Feed(userImage: UIImage(named: "user")!, userName: "IBY", text: textView.text, like: num, uploadImage: UIImage(named: "swift")!))
        setTextView()
    }
    
    // MARK: - 뷰 타이틀
    let plusTitle: UILabel = {
        let label = UILabel()
        label.text = "피드 남기기"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        
        return label
    }()
    
    
    let imageViewer = UIImageView()
    
    // MARK: - 텍스트 뷰 선언
    let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        settingUI()
        setTextView()
    }
    
    // MARK: - 텍스트 뷰 초기 설정
    func setTextView() {
        textView.delegate = self
        textView.text = "이곳에 사진과 함께 적을 글을 입력해주세요!"
        textView.textColor = .lightGray
    }
    
    // MARK: - UI 세팅
    func settingUI() {
        view.addSubview(plusTitle)
        plusTitle.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            
        }
        
        /*
        view.addSubview(imageViewer)
        imageViewer.snp.makeConstraints {
            $0.top.equalTo(plusTitle.snp.bottom).offset(20)
            $0.height.equalTo(200)
            $0.width.equalTo(200)
        }
        */
        
        view.addSubview(textView)
        textView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(300)
            $0.centerY.equalToSuperview()
        }
        
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
            $0.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-30)
        }
    }
    
}

// MARK: - TextView Delegate 설정
extension PlusViewController: UITextViewDelegate {
    
    
    // 입력 시작할 때
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.white
        }
    }
    
    // 빈 화면 터치 시 키보드 닫히는 구문
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // 입력 끝났을 때
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "이곳에 사진과 함께 적을 글을 입력해주세요!"
            textView.textColor = .lightGray
        }
    }
}
