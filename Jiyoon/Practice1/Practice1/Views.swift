//
//  View.swift
//  Practice1
//
//  Created by 박지윤 on 2021/09/17.
//

import Foundation
import UIKit
import SnapKit

class Views: UIViewController, UIScrollViewDelegate{
    
    var view1: UIView = {
        
        let view = UIView()
        var time = ["1시", "2시", "3시", "4시", "5시", "6시", "7시", "8시", "9시", "10시", "11시"]
        
        var locationName = UILabel()
        var locationTemp = UILabel()
        let temperatures = UIStackView()
        var tempHigh = UILabel()
        var tempLow = UILabel()
        var backButton = UIButton()
        
        view.backgroundColor = UIColor(red: 0.24, green: 0.70, blue: 1.00, alpha: 1.00)
        return view
    }()
    
    var view2: UIView = {
        let view = UIView()
        var time = ["1시", "2시", "3시", "4시", "5시", "6시", "7시", "8시", "9시", "10시", "11시"]
        
        var locationName = UILabel()
        var locationTemp = UILabel()
        let temperatures = UIStackView()
        var tempHigh = UILabel()
        var tempLow = UILabel()
        var backButton = UIButton()
        
        view.backgroundColor = UIColor(red: 0.24, green: 0.70, blue: 1.00, alpha: 1.00)
        return view
    }()
    
    var view3: UIView = {
        let view = UIView()
        var time = ["1시", "2시", "3시", "4시", "5시", "6시", "7시", "8시", "9시", "10시", "11시"]
        
        var locationName = UILabel()
        var locationTemp = UILabel()
        let temperatures = UIStackView()
        var tempHigh = UILabel()
        var tempLow = UILabel()
        var backButton = UIButton()
        
        view.backgroundColor = UIColor(red: 0.24, green: 0.70, blue: 1.00, alpha: 1.00)
        return view
    }()
    lazy var views = [view1, view2, view3]
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(views.count), height: view.frame.height)
        
        for i in 0..<views.count {
            scrollView.addSubview(views[i])
            views[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
        }
        
        scrollView.delegate = self
        return scrollView
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = views.count
        pageControl.currentPage = 0
        
        return pageControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(scrollView)
        view.addSubview(pageControl)
        }
    }
