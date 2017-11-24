//
//  SwiftLearning.swift
//  RecordTechnology
//
//  Created by ArthurWang on 2017/11/23.
//  Copyright © 2017年 Monkey King. All rights reserved.
//

import Foundation
import UIKit

class SwiftLearning: UIViewController {
    override func viewDidLoad() {
        print("HXAppConfig.shared.appBuild is \(String(describing: HXAppConfig.shared.appBuild))");
        print("HXAppConfig.shared.appVersion is \(HXAppConfig.shared.appVersion)");
        print("appName is \(HXAppConfig.shared.appName)");
    }
}
