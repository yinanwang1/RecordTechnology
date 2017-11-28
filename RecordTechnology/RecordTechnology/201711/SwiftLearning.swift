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
//        print("HXAppConfig.shared.appBuild is \(String(describing: HXAppConfig.shared.appBuild))");
//        print("HXAppConfig.shared.appVersion is \(String(describing: HXAppConfig.shared.appVersion))");
//        print("appName is \(String(describing: HXAppConfig.shared.appName))");
//
//        print("isChinese \(HXSLocalHelper.isLocaleChinese())")
//        print("isChinese2 \(HXSLocalHelper.isLocaleChinese())")
        print("currentAppLanguage is \(HXSLocalHelper.currentAppLanguage())")
    }


    @IBAction func onClickPushBtn(_ sender: Any) {
        let vc:SwiftViewController = SwiftViewController.controllerFromXib() as! SwiftViewController;

        self.navigationController?.pushViewController(vc, animated: true);
    }


}
