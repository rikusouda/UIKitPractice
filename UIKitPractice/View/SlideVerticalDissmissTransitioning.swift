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

class SlideVerticalDissmissTransitioning: NSObject {
    let intractiveTransition = UIPercentDrivenInteractiveTransition()
    weak var dissmissTransitionable: SlideVerticalDissmissTransitionable!
    var isIntractive = false
    
    func getPercentageInteractiveTransition() -> UIPercentDrivenInteractiveTransition? {
        // don't use transition when dismiss without interacive
        return self.isIntractive ? self.intractiveTransition : nil
    }
    
    init(dissmissTransitionable: SlideVerticalDissmissTransitionable) {
        self.dissmissTransitionable = dissmissTransitionable
        super.init()
        
        let viewPanRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(_:)))
        viewPanRecognizer.delegate = self
        dissmissTransitionable.viewForTransition.addGestureRecognizer(viewPanRecognizer)
    }
}

extension SlideVerticalDissmissTransitioning: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else {
            transitionContext.completeTransition(false)
            return
        }
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            fromView.transform = .init(translationX: 0, y: fromView.bounds.height)
        }, completion: { _ in
            if transitionContext.transitionWasCancelled {
                transitionContext.completeTransition(false)
            } else {
                transitionContext.completeTransition(true)
            }
        })
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
