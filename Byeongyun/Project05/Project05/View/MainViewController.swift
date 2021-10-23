//
//  ViewController.swift
//  Project05
//
//  Created by ITlearning on 2021/10/08.
//

import UIKit
import SnapKit
import PhotosUI

class MainViewController: UIViewController {
    private let picker = UIImagePickerController()
    private let tableView = UITableView()
    private var select: Int = 0
    private var parentId = 0
    private let id = Int.random(in: 0...100)
    private var datas = [Folder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        picker.delegate = self
        configureUI()
        readData()
        if navigationItem.rightBarButtonItem == nil {
            configureNavigationBar()
        }
        configureTableView()
    }
    
    @objc func plusAction() {
        
        let alert = UIAlertController(title: "선택", message: "어떤 것을 추가하시고 싶으세요?", preferredStyle: .actionSheet)
        let cell = UIAlertAction(title: "폴더", style: .default, handler: { _ in
            let cellAlert = UIAlertController(title: "폴더 이름 입력", message: "폴더 이름을 입력해주세요.", preferredStyle: .alert)
            cellAlert.addTextField()
            
            let ok = UIAlertAction(title: "확인", style: .default) { ok in
                guard let text = cellAlert.textFields?[0].text else { return }
                let folder = Folder(index: UUID(), id: Int.random(in: 0...Int.max/2), parentId: 0, name: text, photo: nil)
                self.datas.append(folder)
                self.tableView.reloadData()
                CoreDataManager.shared.crateFolder(folder)
            }
            let cancel = UIAlertAction(title: "닫기", style: .cancel, handler: nil)
            cellAlert.addAction(cancel)
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
        present(picker, animated: true, completion: nil)
    }
    
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            present(picker, animated: true, completion: nil)
        } else {
            print("Nope")
        }
    }
    
    private func readData() {
        datas = CoreDataManager.shared.getFolder(parentId)
        print(datas)
    }
    
    private func configureTableView() {
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.cellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset.left = 0
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.topItem?.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(plusAction)), animated: true)
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

extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            print(image)
            let folder = Folder(index: UUID(), id: 0, parentId: 0, name: "IMG_\(Int.random(in: 100...10000))", photo: image)
            datas.append(folder)
            tableView.reloadData()
            CoreDataManager.shared.crateFolder(folder)
            dismiss(animated: true, completion: nil)
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellId, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        
        if datas[indexPath.row].photo != nil {
            cell.leftImage = datas[indexPath.row].photo
            cell.midLabel = datas[indexPath.row].name
        } else {
            cell.update = datas[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if datas[indexPath.row].photo == nil {
            let fold = FoldViewController(id: datas[indexPath.row].id,parentId: 0)
            fold.navigationItem.title = datas[indexPath.row].name
            navigationController?.pushViewController(fold, animated: true)
        } else {
            
            var tmp: [URL] = []
            for data in datas {
                if data.photo != nil {
                    guard let photo = data.photo else { return }
                    tmp.append(photo)
                }
            }
            let selectIndex = indexPath.row - (datas.count - tmp.count)
            let select = SelectImageViewController(index: selectIndex, array: tmp)
            select.modalPresentationStyle = .fullScreen
            
            present(select, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let edit = UIContextualAction(style: .normal, title: "수정") { (_,_, success: @escaping (Bool) -> Void) in
            
            let alert = UIAlertController(title: "수정하기", message: "원하는 폴더 이름을 작성해주세요!", preferredStyle: .alert)
            alert.addTextField()
            let cancel = UIAlertAction(title: "닫기", style: .cancel, handler: nil)
            let ok = UIAlertAction(title: "적용", style: .default) { _ in
                guard let text = alert.textFields?[0].text else { return }
                CoreDataManager.shared.updateFolder(self.datas[indexPath.row], name: text)
                self.readData()
                self.tableView.reloadData()
            }
            
            alert.addAction(cancel)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            success(true)
        }
        
        let delete = UIContextualAction(style: .normal, title: "삭제") { (_,_, success: @escaping (Bool) -> Void) in
            CoreDataManager.shared.deleteFolder(self.datas[indexPath.row].index)
            self.datas.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            success(true)
        }
        
        delete.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [delete, edit])
    }
}

