//
//  SlideVerticalDissmissTransitioning.swift
//  UIKitPractice
//
//  Created by Yuki Yoshioka on 2017/11/12.
//  Copyright © 2017年 rikusouda. All rights reserved.
//

import UIKit

protocol SlideVerticalDissmissTransitionable: class {
    func dismiss(animated: Bool, completion: (() -> Void)?)
    var viewForTransition: UIView { get }
}

extension SlideVerticalDissmissTransitionable where Self: UIViewController {
    var viewForTransition: UIView { return self.view }
}

class SlideVerticalDissmissTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    let intractiveTransition = UIPercentDrivenInteractiveTransition()
    weak var dissmissTransitionable: SlideVerticalDissmissTransitionable!
    var isIntractive = false
    
    func getPercentageInteractiveTransition() -> UIPercentDrivenInteractiveTransition? {
        return self.isIntractive ? self.intractiveTransition : nil
    }
    
    init(dissmissTransitionable: SlideVerticalDissmissTransitionable) {
        self.dissmissTransitionable = dissmissTransitionable
        super.init()
        
        let viewPanRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(_:)))
        viewPanRecognizer.delegate = self
        dissmissTransitionable.viewForTransition.addGestureRecognizer(viewPanRecognizer)
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) else {
            transitionContext.completeTransition(false)
            return
        }
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            fromVC.view.frame.origin.y = UIScreen.main.bounds.height
        }) { _ in
            if transitionContext.transitionWasCancelled {
                transitionContext.completeTransition(false)
            } else {
                fromVC.view.removeFromSuperview()
                transitionContext.completeTransition(true)
            }
        }
    }
}

extension SlideVerticalDissmissTransitioning: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        guard handlePanGestureShouldBegin(sender),
            let senderView = sender.view else {
            return
        }
        let translation = sender.translation(in: senderView)
        let progress = min(1.0, max(0.0, translation.y / senderView.bounds.height))
        
        switch sender.state {
        case .began:
            self.isIntractive = true
            self.dissmissTransitionable.dismiss(animated: true, completion: nil)
        case .changed:
            self.intractiveTransition.update(progress)
        case .cancelled,
             .ended:
            self.isIntractive = false
            if progress > 0.3 {
                self.intractiveTransition.finish()
            } else {
                self.intractiveTransition.cancel()
            }
            break
        default:
            break
        }
    }
    
    func handlePanGestureShouldBegin(_ sender: UIPanGestureRecognizer) -> Bool {
        guard let senderView = sender.view else {
            return false
        }
        if !self.isIntractive {
            if sender.velocity(in: senderView).y < 1 {
                return false
            }
        }
        return true
    }
}
