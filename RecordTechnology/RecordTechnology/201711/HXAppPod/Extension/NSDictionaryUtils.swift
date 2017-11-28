//
//  NSDictionaryUtils.swift
//  RecordTechnology
//
//  Created by ArthurWang on 2017/11/28.
//  Copyright © 2017年 Monkey King. All rights reserved.
//

import Foundation

extension NSDictionary {
    @objc func dictionaryByReplacingNullsWithStrings() -> NSDictionary {
        let replaced = NSMutableDictionary.init(dictionary: self);
        let blank = "";

        for key in self.allKeys {
            let object = self.object(forKey: key);

            if object is NSNull {
                replaced.setObject(blank, forKey: key as! NSCopying);
            } else if object is NSDictionary {
                let value:NSDictionary = object as! NSDictionary;
                replaced.setObject(value, forKey: key as! NSCopying);
            }
        }

        return NSDictionary.init(dictionary: replaced);
    }

    @objc func objectForKeyExpectNSNull(aKey: Any) -> Any? {
        var value = self.object(forKey: aKey);

        if value is NSNull {
            value = nil;
        }

        return value;
    }

    @objc func objectForKeyExpectNil(aKey: Any) -> Any? {
        var value = self.object(forKey: aKey);

        if nil == value {
            value = NSNull();
        }

        return value;
    }
}


extension NSMutableDictionary {
    @objc func setObjectExceptNil(anObject: Any?, aKey:Any?) {
        if nil == anObject || nil == aKey {
            return;
        }

        if aKey is NSCopying {
            self.setObject(anObject!, forKey: aKey as! NSCopying);
        }
    }
}





