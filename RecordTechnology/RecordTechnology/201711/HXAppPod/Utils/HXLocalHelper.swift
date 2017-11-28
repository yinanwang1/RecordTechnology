//
//  HXLocalHelper.swift
//  RecordTechnology
//
//  Created by ArthurWang on 2017/11/28.
//  Copyright © 2017年 Monkey King. All rights reserved.
//

import Foundation

var isInited:Bool = false;
var isChinese:Bool = false;

class HXSLocalHelper: NSObject {
    @objc class func isLocaleChinese() -> Bool {
        #if INTERNATIONAL_VERSION
            return false;
        #endif

        if !isInited {
            isInited = true;
            let languages:Array<NSString> = UserDefaults.standard.object(forKey: "AppleLanguages") as! Array<NSString>;
            let currentLanguage:NSString = languages[0];
            if currentLanguage == "zh-Hans-CN" {
                isChinese = true;
            } else {
                isChinese = false;
            }
        }

        return isChinese;
    }

    @objc class func currentAppLanguage() -> String {
        #if INTERNATIONAL_VERSION
            return "en";
        #endif

        let languages:Array<String> = UserDefaults.standard.object(forKey: "AppleLanguages") as! Array<String>;
        let currentLanguage = languages[0];

        return currentLanguage;
    }


}
