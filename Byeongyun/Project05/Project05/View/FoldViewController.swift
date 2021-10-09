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

class FoldViewController: UIViewController {
    private let picker = UIImagePickerController()
    private let tableView = UITableView()
    var select: Int = 0
    var datas: [Folder] = []
    var parentId: Int
    var id: Int
    var level: Int
    
    init(level: Int, parentId: Int) {
        self.level = level
        self.id = level
        self.parentId = parentId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        picker.delegate = self
        print("id, parentId : \(id), \(parentId)")
        print()
        configureUI()
        readData()
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
                let folder = Folder(level: self.level, id: self.id, parentId: self.parentId, name: (cellAlert.textFields?[0].text!)!, photo: nil)
                print("여기서 추가하면",self.id)
                self.datas.append(folder)
                self.tableView.reloadData()
                CoreDataManager.shared.crateFolder(folder)
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
    
    private func readData() {
        datas = CoreDataManager.shared.getFolder(id)
    }
    
    private func configureTableView() {
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.cellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset.left = 0
        
    }
    
    private func configureNavigationBar() {
        let button = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(anotherAction))
        navigationItem.rightBarButtonItem = button
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
            let folder = Folder(level: level, id: id, parentId: parentId, name: "IMG_\(Int.random(in: 100...10000))", photo: image)
            datas.append(folder)
            tableView.reloadData()
            CoreDataManager.shared.crateFolder(folder)
            dismiss(animated: true, completion: nil)
        }
    }
}

extension FoldViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.cellId, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        if datas[indexPath.row].photo != nil {
            cell.leftImage = datas[indexPath.row].photo
            cell.midLabel = datas[indexPath.row].name
        } else {
            cell.update = datas[indexPath.row]
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        select = indexPath.row
        
        if datas[indexPath.row].photo == nil {
            let fold = FoldViewController(level: level+1, parentId: id)
            fold.navigationItem.title = datas[indexPath.row].name
            navigationController?.pushViewController(fold, animated: true)
        } else {
            var tmp: [URL] = []
            for i in datas {
                if i.photo != nil {
                    tmp.append(i.photo!)
                }
            }
            let select = SelectImageViewController(index: indexPath.row, array: tmp)
            select.modalPresentationStyle = .fullScreen
            
            present(select, animated: true, completion: nil)
        }
    }
}

