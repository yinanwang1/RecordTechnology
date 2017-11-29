//
//  UIImageViewRoundCorner.swift
//  RecordTechnology
//
//  Created by ArthurWang on 2017/11/29.
//  Copyright © 2017年 Monkey King. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    @objc func cornerRadiusForImageViewWithImage(image:UIImage) {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale);
        let bezierPath = UIBezierPath.init(roundedRect: self.bounds, cornerRadius: self.frame.size.width / 2);
        bezierPath.addClip();

        image.draw(in: self.bounds);

        self.image = UIGraphicsGetImageFromCurrentImageContext();

        UIGraphicsEndImageContext();
    }
}
