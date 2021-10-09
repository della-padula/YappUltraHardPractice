//
//  InsideViewController.swift
//  Project4
//
//  Created by 박지윤 on 2021/10/09.
//

import Foundation
import UIKit
class FolderViewController:  UIViewController{
    let folder: Folder
    override func viewDidLoad() {
        view.backgroundColor = .white
    }
    init(_ folder: Folder) {
        self.folder = folder
        super.init(nibName: nil, bundle: nil)
        print(folder.id)
        print(folder.folderName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
