//
//  ViewController.swift
//  Project05
//
//  Created by ITlearning on 2021/10/08.
//

import UIKit
import SnapKit
import PhotosUI

var array = [Test(image: UIImage(systemName: "folder.fill")!, name: "app01")]
//var folder = []
class MainViewController: UIViewController {
    private var itemProviders: [NSItemProvider] = []
    private let tableView = UITableView()
    
    var select: Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        if navigationItem.rightBarButtonItem == nil {
            configureNavigationBar()
        }
        configureTableView()
    }
    
    @objc func plusAction() {
        print("추가")
        
        let alert = UIAlertController(title: "선택", message: "어떤 것을 추가하시고 싶으세요?", preferredStyle: .actionSheet)
        let cell = UIAlertAction(title: "폴더", style: .default, handler: { _ in
            let cellAlert = UIAlertController(title: "폴더 이름 입력", message: "폴더 이름을 입력해주세요.", preferredStyle: .alert)
            cellAlert.addTextField()
            print("일단 ㅇㅋ")
            
            let ok = UIAlertAction(title: "확인", style: .default) { ok in
                array.append(Test(image: UIImage(systemName: "folder.fill")!, name: cellAlert.textFields![0].text!))
                //folder.append(cellAlert.textFields![0].text!)
                self.tableView.reloadData()
                print(array)
            }
            
            cellAlert.addAction(ok)
            self.present(cellAlert, animated: true, completion: nil)
            
        })
        let photo = UIAlertAction(title: "사진", style: .default, handler: { _ in
            var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
            configuration.selectionLimit = 0
            configuration.filter = .any(of: [.images])
            
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        })
        
        alert.addAction(cell)
        alert.addAction(photo)
        present(alert, animated: true, completion: nil)
    }
    
    private func configureCell() {
        
    }
    
    private func configureTableView() {
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.cellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset.left = 0
        
    }
    
    private func configureNavigationBar() {
        //navigationController?.navigationBar.topItem?.title = "Album"
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

extension MainViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        itemProviders = results.map(\.itemProvider)
        for item in itemProviders {
            if item.canLoadObject(ofClass: UIImage.self) {
                item.loadObject(ofClass: UIImage.self) { image, error in
                    DispatchQueue.main.async {
                        guard let image = image as? UIImage else { return }
                        print(image.accessibilityIdentifier)
                        array.append(Test(image: image, name: "\(array.count+1)"))
                        self.tableView.reloadData()
                        
                    }
                }
            }
        }
        
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.cellId, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        cell.update = array[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        select = indexPath.row
        
        if select != 2 {
            let main = MainViewController()
            main.navigationItem.title = array[indexPath.row].name
            navigationController?.pushViewController(main, animated: true)
            //main.configureNavigationBar()
            //main.navigationItem.backBarButtonItem!.title = array[indexPath.row]
            main.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(plusAction))
        } else {
            
        }
    }
}

