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

class CardTransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate{
    var transitionDuration: Double = 0.8
    var transition: CardTransitionType = .presentation
    let shrinkDuration: Double = 0.2
    var originFrame = CGRect.zero

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        
        toView.clipsToBounds = true
        toView.layer.cornerRadius = 20
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(toView)
        toView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        toView.frame = originFrame
        
        UIView.animate(withDuration: transitionDuration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2, options: .curveEaseOut, animations: {
            toView.transform = .identity
            toView.alpha = 1
        }, completion: { _ in transitionContext.completeTransition(true)})
        
    }
    
    
}
