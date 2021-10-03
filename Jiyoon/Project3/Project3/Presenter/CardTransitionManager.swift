//
//  CardTransitionManager.swift
//  Project3
//
//  Created by 박지윤 on 2021/10/03.
//

import UIKit

enum CardTransitionType {
    case presentation
    case dismiss
}

class CardTransitionManager: NSObject{
    var transitionDuration: Double = 0.8
    var transition: CardTransitionType = .presentation
    let shrinkDuration: Double = 0.2
    
}
extension CardTransitionManager: UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        
    }
    
    
}
//extension CardTransitionManager: UIViewControllerTransitioningDelegate{
//    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
//        transition = .presentation
//
//    }
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        transition = .dismiss
//        return self
//    }
//}
