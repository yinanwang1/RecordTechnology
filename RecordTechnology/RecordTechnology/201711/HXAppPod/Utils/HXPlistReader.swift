//
//  HXPlistReader.swift
//  RecordTechnology
//
//  Created by ArthurWang on 2017/11/24.
//  Copyright © 2017年 Monkey King. All rights reserved.
//

import Foundation

class HXPlistReader: NSObject {
    fileprivate var attributes:NSDictionary? = nil;

    @objc class func plistReaderForFile(file:String) -> HXPlistReader? {
        let reader = HXPlistReader.init();
        let fullPath = Bundle.main.path(forResource: file, ofType: "plist");
        if nil == fullPath {
            return nil;
        }

        reader.attributes = NSDictionary.init(contentsOfFile:fullPath!);

        return reader;
    }

    @objc func allKeys() -> NSArray {
        var keys = self.attributes?.allKeys;
        keys?.sort(by: {String(describing: $0) < String(describing: $1)})
        return keys! as NSArray;
    }

    @objc func stringValueForKey(key: String) -> String {
        return self.attributes?.object(forKey: key) as! String;
    }

    @objc func arrayValueForKey(key: String) -> NSArray {
        return self.attributes?.object(forKey: key) as! NSArray;
    }

    @objc func dictValueForKey(key: String) -> NSDictionary {
        return self.attributes?.object(forKey: key) as! NSDictionary;
    }

    @objc func boolValueForKey(key: String) -> Bool {
        let value = self.attributes?.object(forKey: key);
        if value is NSNumber {
            return (value as! NSNumber).boolValue;
        } else if value is NSString {
            let str = (value as! NSString).lowercased as NSString;
            if ((str.isEqual(to: "yes"))
                || (str.isEqual(to: "no"))) {
                return true;
            } else {
                return false;
            }
        }

        return false
    }

    @objc func intValueForKey(key: String) -> Int {
        let value = self.attributes?.object(forKey: key);
        if value is NSNumber {
            return (value as! NSNumber).intValue;
        } else if value is NSString {
            return Int((value as! NSString).intValue);
        }

        return 0;
    }

    @objc func floatValueForKey(key: String) -> Float {
        let value = self.attributes?.object(forKey: key);
        if value is NSNumber {
            return (value as! NSNumber).floatValue;
        } else if value is NSString {
            return Float((value as! NSString).floatValue);
        }

        return 0;
    }

    @objc func stringValueForKey(key:String, defaultValue:String) -> String {
        let value = self.attributes?.object(forKey: key);
        if nil == value {
            return defaultValue;
        } else {
            return value as! String;
        }
    }

    @objc func arrayValueForKey(key:String, defaultValue:Array<Any>) -> Array<Any> {
        let value = self.attributes?.object(forKey: key);
        if nil == value {
            return defaultValue;
        } else {
            return value as! Array<Any>;
        }
    }

    @objc func dictValueForKey(key:String, defaultValue:Dictionary<String, Any>) -> Dictionary<String, Any> {
        let value = self.attributes?.object(forKey: key);
        if nil == value {
            return defaultValue;
        } else {
            return value as! Dictionary<String, Any>;
        }
    }

    @objc func boolValueForKey(key:String, defaultValue:Bool) -> Bool {
        let value = self.attributes?.object(forKey: key);
        if nil == value {
            return defaultValue;
        }

        if value is NSNumber {
            return (value as! NSNumber).boolValue;
        } else if value is NSString {
            let str = (value as! NSString).lowercased as NSString;
            if ((str.isEqual(to: "yes"))
                || (str.isEqual(to: "no"))) {
                return true;
            } else {
                return false;
            }
        }

        return false;
    }

    @objc func intValueForKey(key:String, defaultValue:Int) -> Int {
        let value = self.attributes?.object(forKey: key);

        if nil == value {
            return defaultValue;
        }

        if value is NSNumber {
            return (value as! NSNumber).intValue;
        } else if value is NSString {
            return Int((value as! NSString).intValue);
        }

        return 0;
    }

    @objc func floatValueForKey(key:String, defaultValue:Float) -> Float {
        let value = self.attributes?.object(forKey: key);

        if nil == value {
            return defaultValue;
        }

        if value is NSNumber {
            return (value as! NSNumber).floatValue;
        } else if value is NSString {
            return Float((value as! NSString).floatValue);
        }

        return 0;
    }

}
