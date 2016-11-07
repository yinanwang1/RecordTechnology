//
//  WatchStopViewController.swift
//  RecordTechnology
//
//  Created by ArthurWang on 2016/11/4.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

import UIKit

class WatchStopViewController: UIViewController, CAAnimationDelegate {

    @IBOutlet weak var arrowImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let anchor = CGPoint.init(x: 0.0, y: 0.5)
//        self.arrowImageView.layer.anchorPoint = anchor
    }
    

    // MARK: - Target Methods
    
    @IBAction func onClickRotateBtn(_ sender: Any) {
        
//        self.arrowImageView.transform = CGAffineTransform.identity
//        
//        UIView.animate(withDuration: 1.0, animations: {
//            self.arrowImageView.transform = CGAffineTransform.init(rotationAngle: CGFloat(M_PI))
//        }, completion: nil)
        
        let animation = CABasicAnimation.init(keyPath: "transform")
        animation.delegate = self
        animation.toValue = NSValue.init(caTransform3D: CATransform3DMakeRotation(CGFloat(M_PI), 0, 0, 1.0))
        animation.duration = 2
        animation.isCumulative = true
        animation.repeatCount = Float(INT_MAX)
        animation.autoreverses = true
        
        self.arrowImageView.layer.add(animation, forKey: "animation")
    }
    

}
