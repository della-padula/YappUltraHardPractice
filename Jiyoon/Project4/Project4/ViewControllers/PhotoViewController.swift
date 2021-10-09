//
//  PhotoViewController.swift
//  Project4
//
//  Created by 박지윤 on 2021/10/09.
//

import Foundation
import UIKit
import CoreData
import SnapKit

class PhotoViewController: UIViewController, UINavigationControllerDelegate {
    var imageView = UIImageView()
    var saveButton = UIButton()
    var imagePicker = UIImagePickerController()
    var arrPhotos: [Photo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        openImagePicker()
        setUIItems()
    }
    
    func setUIItems() {
        saveButton = {
            let button = UIButton()
            button.setTitle("저장", for: .normal)
            button.setTitleColor(.systemBlue, for: .normal)
            button.addTarget(self, action: #selector(saveImageButtonPressed(_:)), for: .touchUpInside)
            return button
        }()
        
        view.addSubview(imageView)
        view.addSubview(saveButton)
        imageView.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview()
            maker.width.equalToSuperview().offset(-100)
            maker.height.equalToSuperview().offset(-400)
        }
        saveButton.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(50)
            maker.centerX.equalToSuperview()
        }
    }
}

extension PhotoViewController: UIImagePickerControllerDelegate {
    func openImagePicker() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        if let img = info[.originalImage] as? UIImage {
            imageView.image = img
        }
    }
    
    @objc
    func saveImageButtonPressed(_ sender : UIBarButtonItem) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let photo = NSEntityDescription.insertNewObject(forEntityName: "Photo", into: context) as! Photo
        let jpeg = self.imageView.image?.jpegData(compressionQuality: 1.0)
        
        photo.image = jpeg
        
        dismiss(animated: true, completion: nil)
        do {
            try context.save()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
