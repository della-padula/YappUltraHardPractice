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
    private var dayCounter = [CGFloat](repeating: 0, count: 31)
    private var graphCounter = [CGFloat](repeating: 0, count: 31)
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //configurePicker()
        configureLayout()
        configureCollectionView()
        githubAPI()
        drawGraph()
    }

    private func drawGraph() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3) {
            self.presenter.fetch { day in
                self.dayCounter = day
                self.graphCounter = day
                let padding: CGFloat = 30
                let frame = CGRect(x: 0, y: 0, width: self.view.frame.width - padding * 2, height: self.view.frame.height - padding * 4)
                let graphView = GraphView(frame: frame, values: self.graphCounter)
                graphView.backgroundColor = .systemGray5
                self.view.addSubview(graphView)
                graphView.snp.makeConstraints {
                    $0.top.equalTo(self.collectionView.snp.bottom)
                    $0.centerX.equalToSuperview()
                    $0.width.equalTo(350)
                    $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-20)
                }
                self.collectionView.reloadData()
            }
        }
    }

    private func githubAPI() {
        presenter.fetchData { arr in
            self.array = arr
            print(self.array)
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
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-50)
            $0.width.equalTo(350)
            $0.height.equalTo(300)
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
        let index = presenter.showPickerArray()
        return 3
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        let index = presenter.showPickerArray()

        return index[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        presenter.selectFilter(presenter.showPickerArray()[row])
    }
}
