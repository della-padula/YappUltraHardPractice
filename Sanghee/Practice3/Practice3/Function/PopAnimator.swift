//
//  PopAnimator.swift
//  Practice3
//
//  Created by leeesangheee on 2021/10/04.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let duration: TimeInterval = 1.0
    var presenting = true
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        
        toView.clipsToBounds = true
        toView.layer.cornerRadius = 12
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(toView)
        toView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        toView.frame = CGRect.zero
        
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.3,
                       animations: {
                        toView.transform = .identity
                        toView.center = containerView.center
                        toView.frame.size = containerView.frame.size
                       },
                       completion: { _ in
                        transitionContext.completeTransition(true)
                       })
    }
}
