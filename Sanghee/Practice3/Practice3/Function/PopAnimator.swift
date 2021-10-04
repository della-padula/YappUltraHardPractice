//
//  PopAnimator.swift
//  Practice3
//
//  Created by leeesangheee on 2021/10/04.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let duration: TimeInterval = 1.0
    let padding: CGFloat = 16
    var cPointY: CGFloat = 0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView

        let toView = transitionContext.view(forKey: .to)
        let fromView = transitionContext.view(forKey: .from)
        
        if let toView = toView {
            containerView.addSubview(toView)
            containerView.bringSubviewToFront(toView)
            
            toView.clipsToBounds = true
            toView.layer.cornerRadius = 12
            toView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            
            UIView.animate(withDuration: duration,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0.1,
                           animations: {
                            toView.transform = .identity
                            toView.frame = containerView.frame
                           },
                           completion: { _ in
                            transitionContext.completeTransition(true)
                           })
        }
        if let fromView = fromView {
            containerView.addSubview(fromView)
            containerView.bringSubviewToFront(fromView)
            
            fromView.clipsToBounds = true
            fromView.layer.cornerRadius = 12
            fromView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            
            let width = containerView.frame.width - self.padding * 2

            UIView.animate(withDuration: duration,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0.1,
                           animations: {
                            fromView.transform = .identity
                            fromView.frame = CGRect(x: self.padding,
                                                    y: self.cPointY - (width / 2),
                                                    width: width,
                                                    height: width)
                           },
                           completion: { _ in
                            transitionContext.completeTransition(true)
                           })
        }
    }
}
