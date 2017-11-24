//
//  HXAppConfig.swift
//  RecordTechnology
//
//  Created by ArthurWang on 2017/11/24.
//  Copyright © 2017年 Monkey King. All rights reserved.
//

import Foundation
import MessageUI

class HXAppConfig: NSObject {

    @objc var appName:String?                   = nil;
    @objc var appVersion:String?                = nil;
    @objc var appBuild:String?                  = nil;

    // 单例
    static let shared = HXAppConfig.init();
    private override init() {
        appName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String;
        appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String;
        appBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as? String;
    }

}
