//
//  YYTestSwiftViewController.swift
//  RecordTechnology
//
//  Created by ArthurWang on 2017/11/16.
//  Copyright © 2017年 Monkey King. All rights reserved.
//

import Foundation
import UIKit


@objc class YYTestSwiftViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad();

        let dic:Dictionary<String, Int> = ["1":3, "2":4];
        var copiedDic = dic;
        copiedDic["1"] = 123

        print("dic is \(dic)");
        print("copiedDic is \(copiedDic)")

        let possibleNumber = "123"
        if let actualNumber = Int(possibleNumber) {
            print("actualNumber is \(actualNumber)")

        } else {
            print("error is 1")
        }

        self.testDictionary(inDic:dic);

    }

    func testDictionary(inDic:Dictionary<String, Int>) -> Void {

        print("testDictionary dic is \(inDic)");
    }
}
