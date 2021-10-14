//
//  ViewController.swift
//  Practice6
//
//  Created by ITlearning on 2021/10/14.
//

import UIKit
import SnapKit
import Alamofire

class ViewController: UIViewController {
    private let month = Month()
    private var data: [Item] = []
    private var array: [String] = []
    private var monthCount: [CGFloat] = []
    private var dayCounter = [CGFloat](repeating: 0, count: 31)
    private var graphCounter = [CGFloat](repeating: 0, count: 31)
    private var selectText = ""
    private var sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    private let presenter = Presenter()
    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white

        return collectionView
    }()

    private let githubLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "GitHub-Emblem")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let graphPicker: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .bezel
        textField.placeholder = "그래프를 선택하세요. [기본값: 일별]"
        textField.borderStyle = .roundedRect
        textField.frame = CGRect(x: 0, y: 0, width: 150, height: 35)
        return textField
    }()

    private let picker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configurePicker()
        configureLayout()
        configureCollectionView()
        githubAPI()
        drawCollectionView()
    }

    private func configurePicker() {
        picker.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 220)
        picker.delegate = self
        picker.dataSource = self

        let pickerToolBar: UIToolbar = UIToolbar()
        pickerToolBar.barStyle = .default
        pickerToolBar.isTranslucent = true
        pickerToolBar.backgroundColor = .lightGray
        pickerToolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(pickDone))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let cancelButton = UIBarButtonItem(title: "닫기", style: .done, target: self, action: #selector(pickCancel))

        pickerToolBar.setItems([cancelButton, flexibleSpace, doneButton], animated: true)
        pickerToolBar.isUserInteractionEnabled = true
        graphPicker.inputView = picker
        graphPicker.inputAccessoryView = pickerToolBar
    }

    @objc
    func pickDone() {
        print("눌리긴함?")
        graphPicker.text = selectText
        graphPicker.resignFirstResponder()
        if presenter.showPick() == 0 {
            self.graphCounter = self.dayCounter
            normalGraph()
        } else {
            drawGraph(presenter.showPick())
        }
    }

    @objc
    func pickCancel() {
        graphPicker.resignFirstResponder()
        graphPicker.text = ""
    }

    private func drawCollectionView() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3) {
            self.presenter.fetch() { day in
                self.dayCounter = day
                self.graphCounter = day
                self.normalGraph()
                self.collectionView.reloadData()
            }
        }
    }

    private func normalGraph() {

        let padding: CGFloat = 100
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width - padding * 2, height: self.view.frame.height - padding * 4)
        let graphView = GraphView(frame: frame, values: self.graphCounter)
        print(self.graphCounter)
        graphView.backgroundColor = .systemGray5
        graphView.snp.removeConstraints()
        self.view.addSubview(graphView)
        graphView.snp.makeConstraints {
            $0.top.equalTo(self.graphPicker.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(self.view.safeAreaLayoutGuide.snp.width)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }

    private func drawGraph(_ index: Int) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3) {
            self.presenter.fetchMonthData(index) { day in
                self.graphCounter = day
                self.normalGraph()
            }
        }
    }

    private func githubAPI() {
        presenter.fetchData() { arr in
            self.array = arr
        }
        presenter.fetchMonthData(0) { count in
            self.graphCounter = count

        }
    }
    private func configureCollectionView() {
        collectionView.register(GreenCollectionViewCell.self, forCellWithReuseIdentifier: GreenCollectionViewCell.cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func configureLayout() {
        view.addSubview(githubLogoImageView)
        githubLogoImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            $0.height.equalTo(100)
            $0.width.equalTo(150)
        }

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            let height = view.layer.frame.height
            $0.top.equalTo(githubLogoImageView.snp.bottom).offset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-10)

            $0.height.equalTo(height/4)
        }

        view.addSubview(graphPicker)
        graphPicker.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)

        }
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return month.setNumber()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GreenCollectionViewCell.cellId, for: indexPath) as? GreenCollectionViewCell else { return UICollectionViewCell() }
        cell.changeColor = dayCounter[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height

        let itemsPerRow: CGFloat = 9
        let itemsPerCol: CGFloat = 7

        let widthPadding = sectionInset.left * (itemsPerRow+1)
        let heightPadding = sectionInset.top * (itemsPerCol+1)

        let cellWidth = (width - widthPadding) / itemsPerRow
        let cellHeight = (height - heightPadding) / itemsPerCol

        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        let index = presenter.showPickerArray()

        return index[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectText = presenter.showPickerArray()[row]
        presenter.selectFilter(row)
    }
}
