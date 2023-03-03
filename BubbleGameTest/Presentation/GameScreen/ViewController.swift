//
//  ViewController.swift
//  BubbleGameTest
//
//  Created by Vladislav Panev on 03.03.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private var bubbleViews: [CustomCircleView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func panAction2(_ sender: UIPanGestureRecognizer) {
        let gestureTranslation = sender.translation(in: view)
        
        guard let gestureView = sender.view else { return }
        
        gestureView.center = CGPoint(
            x: gestureView.center.x + gestureTranslation.x,
            y: gestureView.center.y + gestureTranslation.y
        )
        sender.setTranslation(.zero, in: view)
        
        guard sender.state == .ended else { return }
        
        intersectionLogic(for: gestureView)
    }
    
    private func intersectionLogic(for gestureView: UIView) {
        for bubble in bubbleViews {
            if gestureView.frame.intersects(bubble.frame) && bubble !== gestureView && !bubble.isHidden {
                
                var maxFrame: CGRect = .zero
                var animatedView: CustomCircleView?
                
                if gestureView.frame.size.width > bubble.frame.size.width {
                    bubble.isHidden = true
                    maxFrame = gestureView.frame
                    animatedView = gestureView as? CustomCircleView
                } else {
                    gestureView.isHidden = true
                    maxFrame = bubble.frame
                    animatedView = bubble
                }
                
                guard let animatedView = animatedView else { return }
                
                UIView.animate(withDuration: 0.2) {
                    animatedView.circleBackgroundColor = .blue
                    animatedView.frame = maxFrame.insetBy(dx: -10, dy: -10)
                    animatedView.roundCircle = true
                }
                break
            }
        }
    }
}
