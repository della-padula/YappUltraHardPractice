//
//  View.swift
//  WeatherApp
//
//  Created by 박지윤 on 2021/09/18.
//

import Foundation
import SnapKit
import UIKit

class Views: UIViewController, UIScrollViewDelegate{
    var viewSeoul: UIView = {
        let pageView = UIView()
        var timeList = ["1시", "2시", "3시", "4시", "5시", "6시", "7시", "8시", "9시", "10시", "11시"]
        
        var locationNameLabel = UILabel()
        var locationTempLabel = UILabel()
        let temperaturesView = UIStackView()
        var tempHighLabel = UILabel()
        var tempLowLabel = UILabel()
        var backButton = UIButton()
        
        pageView.backgroundColor = UIColor(red: 0.24, green: 0.70, blue: 1.00, alpha: 1.00)
        return pageView
    }()
    
    var viewDaejeon: UIView = {
        let pageView = UIView()
        var timeList = ["1시", "2시", "3시", "4시", "5시", "6시", "7시", "8시", "9시", "10시", "11시"]
        
        var locationNameLabel = UILabel()
        var locationTempLabel = UILabel()
        let temperaturesVIew = UIStackView()
        var tempHighLabel = UILabel()
        var tempLowLabel = UILabel()
        var backButton = UIButton()
        
        pageView.backgroundColor = UIColor(red: 0.24, green: 0.70, blue: 1.00, alpha: 1.00)
        return pageView
    }()
    
    var viewDaegu: UIView = {
        let pageView = UIView()
        var timeList = ["1시", "2시", "3시", "4시", "5시", "6시", "7시", "8시", "9시", "10시", "11시"]
        
        var locationNameLabel = UILabel()
        var locationTempLabel = UILabel()
        let temperaturesVIew = UIStackView()
        var tempHighLabel = UILabel()
        var tempLowLabel = UILabel()
        var backButton = UIButton()
        
        pageView.backgroundColor = UIColor(red: 0.24, green: 0.70, blue: 1.00, alpha: 1.00)
        return pageView
    }()
    
    var viewBusan: UIView = {
        let pageView = UIView()
        var timeList = ["1시", "2시", "3시", "4시", "5시", "6시", "7시", "8시", "9시", "10시", "11시"]
        
        var locationNameLabel = UILabel()
        var locationTempLabel = UILabel()
        let temperaturesVIew = UIStackView()
        var tempHighLabel = UILabel()
        var tempLowLabel = UILabel()
        var backButton = UIButton()
        
        pageView.backgroundColor = UIColor(red: 0.24, green: 0.70, blue: 1.00, alpha: 1.00)
        return pageView
    }()
    
    lazy var views = [viewSeoul, viewDaejeon, viewDaegu, viewBusan]
    
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
