//
//  PlusViewController.swift
//  Practice1
//  게시글 추가 뷰 컨트롤러
//  Created by ITlearning on 2021/09/16.
//

import UIKit
import SnapKit
class PlusViewController: UIViewController {

    private let picker = UIImagePickerController()
    private var selectImage = UIImage()
    
    // MARK: - 버튼 선언 공간
    // 취소버튼
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(plusViewDismissButtonAction), for: .touchUpInside)
        return button
    }()
    // 저장버튼
    private let saveButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 150))
        button.setTitle("저장", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        return button
    }()
    // 사진 선택 버튼
    private let chooseImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("사진 선택하기", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(chooseImage), for: .touchUpInside)

        return button
    }()
    
    
    // MARK: - 버튼 액션 구현 공간
    @objc
    func plusViewDismissButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc
    func saveButtonAction() {
        let num : Int = Int(arc4random() % 100)
        if writingTextView.text != "이곳에 사진과 함께 적을 글을 입력해주세요!" && !writingTextView.text.isEmpty && selectedImageViewer.image != nil {
            feedArray.insert(Feed(userImage: UIImage(named:"user")!, userName: "IBY", text: writingTextView.text, like: num, uploadImage: selectImage, time: Date()), at: 0)
            let done = UIAlertController(title: "등록성공", message: "등록이 성공되었습니다. \n 등록 뷰를 닫으시겠습니까?", preferredStyle: .alert)
            let ok = UIAlertAction(title: "닫기", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            })
            let no = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
            
            done.addAction(no)
            done.addAction(ok)
            
            present(done, animated: true, completion: nil)
            setTextView()
        } else {
            let errorAlert = UIAlertController(title: "에러발생!", message: "입력된 것이 없거나, 사진이 없을 수 있습니다!", preferredStyle: .alert)
            let ok = UIAlertAction(title: "닫기", style: .default, handler: nil)
            
            errorAlert.addAction(ok)
            present(errorAlert, animated: true, completion: nil)
        }
    }
    @objc
    func chooseImage() {
        let alert = UIAlertController(title: "원하는 방법", message: "사진을 가져올 방법을 고르세요!", preferredStyle: .actionSheet)
        let library = UIAlertAction(title: "사진앨범", style: .default, handler: { (action) in
            self.openLibrary()
        })
        
        let camera = UIAlertAction(title: "카메라", style: .default, handler: { (action) in
            self.openCamera()
        })
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
    
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - 사진 뷰 관련 액션들 정의
    func openLibrary() {
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
        } else {
            print("Nope")
        }
    }
    
    // MARK: - 뷰 타이틀
    private let plusTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "피드 남기기"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    // 선택 이미지 뷰어
    private let selectedImageViewer: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        
        if imageView.image == nil {
            imageView.image = UIImage(named: "notSelected")
        }
        
        imageView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        imageView.layer.borderWidth = 0.5
        return imageView
    }()
    
    // MARK: - 텍스트 뷰 선언
    private let writingTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        textView.layer.borderWidth = 0.5
        return textView
    }()
    
    // MARK: - ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        picker.delegate = self
        settingUI()
        setTextView()
    }
    
    // MARK: - 텍스트 뷰 초기 설정
    func setTextView() {
        writingTextView.delegate = self
        writingTextView.text = "이곳에 사진과 함께 적을 글을 입력해주세요!"
        writingTextView.textColor = .lightGray
        writingTextView.font = UIFont.systemFont(ofSize: 13)
        // 키보드 나타날때를 감지하는 옵저버
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        // 키보드 사라질때를 감지하는 옵저버
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - 각 키보드 상황에 대한 액션 정리
    @objc
    func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -150
    }
    @objc
    func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
    
    // MARK: - UI 세팅
    func settingUI() {
        // 타이틀
        view.addSubview(plusTitleLabel)
        plusTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
        }
        // 텍스트 입력 창
        view.addSubview(writingTextView)
        writingTextView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(150)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.centerY.equalToSuperview().offset(100)
        }
        // 취소 버튼
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
            $0.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-30)
        }
        // 저장 버튼
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints {
            $0.top.equalTo(writingTextView.snp.bottom).offset(50)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(100)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-100)
        }
        // 사진 선택시 보여지는 뷰어
        view.addSubview(selectedImageViewer)
        selectedImageViewer.snp.makeConstraints {
            $0.height.equalTo(300)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.bottom.equalTo(writingTextView.snp.top)
        }
        // 이미지 선택 버튼
        view.addSubview(chooseImageButton)
        chooseImageButton.snp.makeConstraints {
            $0.bottom.equalTo(selectedImageViewer.snp.top).offset(-10)
            $0.centerX.equalToSuperview()
        }
    }
}

// MARK: - TextView Delegate 설정
extension PlusViewController: UITextViewDelegate {
    // 입력 시작할 때
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
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
// Q: 왜 UIImagePickerControllerDelegate를 선언할 때 UINavigationControllerDelegate를 같이 선언해주는걸까?
// A: UIImagePickerControllerDelegate의 delegate 속성은 UIImagePickerControllerDelegate와 UINavigationControllerDelegate 프로토콜을 모두 구현하는 객체로 정의되어있다.
// picker의 delegate를 UINavigationControllerDelegate에 위임을 해준 상태다. delegate는 사용자가 이미지나 동영상을 선택하거나 화면을 종료할 때, 알림을 받는다.
extension PlusViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // 사진 선택이 끝난 후 동작 정의
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageViewer.image = image
            selectImage = image
        }
        dismiss(animated: true, completion: nil)
    }
}
