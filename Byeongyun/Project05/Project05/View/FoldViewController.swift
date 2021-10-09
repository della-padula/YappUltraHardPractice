//
//  FoldViewController.swift
//  Project05
//
//  Created by ITlearning on 2021/10/09.
//

import Foundation
//
//  ViewController.swift
//  Project05
//
//  Created by ITlearning on 2021/10/08.
//

import UIKit
import SnapKit
import PhotosUI


var total: Dictionary<String, [Test]> = [:]
class FoldViewController: UIViewController {
    private let picker = UIImagePickerController()
    private let tableView = UITableView()
    var select: Int = 0
    var array: Test
    override func viewWillAppear(_ animated: Bool) {
        if select != 0{
            select -= 1
        }
        
    }
    
    init(_ folder: Test) {
        self.array = folder
        print(array)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        picker.delegate = self
        configureUI()
        if self.navigationItem.rightBarButtonItem == nil {
            configureNavigationBar()
        }
        configureTableView()
    }
    
    @objc
    func anotherAction() {
        print("추가")
        
        let alert = UIAlertController(title: "선택", message: "어떤 것을 추가하시고 싶으세요?", preferredStyle: .actionSheet)
        let cell = UIAlertAction(title: "폴더", style: .default, handler: { _ in
            let cellAlert = UIAlertController(title: "폴더 이름 입력", message: "폴더 이름을 입력해주세요.", preferredStyle: .alert)
            cellAlert.addTextField()
            print("일단 ㅇㅋ")
            
            let ok = UIAlertAction(title: "확인", style: .default) { ok in
                let newF = Test(image: UIImage(systemName: "folder.fill")!, name: cellAlert.textFields![0].text!, photo: [], folder: [])
                self.array.folder.append(newF)
                total[cellAlert.textFields![0].text!]?.append(newF)
                print(total[cellAlert.textFields![0].text!])
                self.tableView.reloadData()
                print(self.array)
            }
            
            cellAlert.addAction(ok)
            self.present(cellAlert, animated: true, completion: nil)
            
        })
        let photo = UIAlertAction(title: "사진", style: .default, handler: { _ in
            let select = UIAlertController(title: "방식 선택", message: "선택해주세요.", preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "카메라", style: .default, handler: { _ in
                self.openCamera()
            })
            let library = UIAlertAction(title: "라이브러리", style: .default, handler: { _ in
                self.openLibrary()
            })
            
            select.addAction(camera)
            select.addAction(library)
            self.present(select, animated: true, completion: nil)
        })
        
        alert.addAction(cell)
        alert.addAction(photo)
        present(alert, animated: true, completion: nil)
    }
    
    private func openLibrary() {
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
        } else {
            print("Nope")
        }
        
    }
    
    private func configureTableView() {
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.cellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset.left = 0
        
    }
    
    private func configureNavigationBar() {
        //navigationController?.navigationBar.topItem?.title = "Album"
        navigationController?.navigationBar.topItem?.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(anotherAction)), animated: true)
    }
    
    private func configureUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

}

extension FoldViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            print(image)
            array.photo.append(image)
            tableView.reloadData()
            dismiss(animated: true, completion: nil)
        }
    }
}

extension FoldViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.folder.count + array.photo.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.cellId, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        if array.folder[indexPath.row] is URL {
            cell.leftImage = array.folder[indexPath.row] as? URL
        } else {
            cell.update = array.folder[indexPath.row] as? Test
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        select = indexPath.row
        
        if select != 2 {
            print("Nope\(array.folder[indexPath.row])")
            let main = FoldViewController(array.folder[indexPath.row] as! Test)
            main.navigationItem.title = (array.folder[indexPath.row] as? Test)?.name
            navigationController?.pushViewController(main, animated: true)
            main.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(anotherAction))
        } else {
            
        }
    }
}

