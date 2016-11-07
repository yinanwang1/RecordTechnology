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
    
    let period = 1.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let anchor = CGPoint.init(x: 1.0, y: 0.5)
        self.arrowImageView.layer.anchorPoint = anchor
    }
    

    // MARK: - Target Methods
    
    @IBAction func onClickRotateBtn(_ sender: Any) {
        
        Timer.scheduledTimer(timeInterval: self.period, target: self, selector: #selector(WatchStopViewController.calcPeriodAndRotate), userInfo: nil, repeats: true)
        
    }
    
    func calcPeriodAndRotate() {
        let angle = arc4random() % 315
        var dot = CGFloat(angle) / 100.0
        
        if CGFloat(M_PI) < dot {
            dot = 3.14
        }
        
        print("dot is \(dot)")
        self.beginRotate(angle: dot)
    }
    
    func beginRotate(angle: CGFloat) {
        let animation = CABasicAnimation.init(keyPath: "transform")
        animation.delegate = self
        let toValue = NSValue.init(caTransform3D: CATransform3DMakeRotation(angle, 0, 0, 1.0))
        animation.toValue = toValue
        animation.duration = self.period
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let keyAnimation:String = "animation \(angle)"
        self.arrowImageView.layer.add(animation, forKey: keyAnimation)
    }

}
