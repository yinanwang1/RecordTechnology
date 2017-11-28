//
//  HXStringUtil.swift
//  RecordTechnology
//
//  Created by ArthurWang on 2017/11/28.
//  Copyright © 2017年 Monkey King. All rights reserved.
//

import Foundation

class HXStringUtil {
    @objc class func substringForString(str:String, beginPattern p0:String, endPattern p1:String) -> String? {
        var substr:String? = nil;
        let pmRange:NSRange = (str as NSString).range(of: p0);
        if NSNotFound != pmRange.location {
            let pmRange1 = (str as NSString).range(of: p1);
            substr = (str as NSString).substring(with: NSMakeRange(pmRange.location + p0.count, pmRange1.location - pmRange.location - p0.count));
            if (substr?.isEmpty)! {
                return nil;
            } else {
                return substr;
            }
        }

        return nil;
    }

    @objc class func shortenString(str:NSString, withFont font:UIFont, toPixelWidth width:CGFloat) -> NSString {
        if 1 >= str.length {
            return str
        }

        if width > str.size(withAttributes: [NSAttributedStringKey.font:font]).width {
            return str;
        }

        var index:Int = 0;
        for i in 1..<str.length {
            index = i;
            let subStr = str.substring(to: i) as NSString;
            if (width - 12) <= subStr.size(withAttributes: [NSAttributedStringKey.font:font]).width {
                break;
            }
        }

        if 1 == index {
            let subStr = str.substring(to: 1) as NSString;
            return subStr.appending("...") as NSString;
        } else {
            let subStr = str.substring(to: index - 1) as NSString;
            return subStr.appending("...") as NSString;
        }
    }

    @objc class func sizeInOnelineOfText(text:NSString, font:UIFont) -> CGSize {
        let result:CGSize = text.size(withAttributes: [NSAttributedStringKey.font:font]);

        return result;
    }

    @objc class func heightForText(text:NSString, havingWidth widthValue:CGFloat, font:UIFont, attributes:NSDictionary?) -> CGFloat {
        var result = font.lineHeight;
        let attr:NSMutableDictionary = NSMutableDictionary.init(object: font, forKey: NSAttributedStringKey.font as NSCopying);
        if nil != attributes {
            attr.addEntries(from: attributes as! [AnyHashable: Any]);
        }
        let frame = text.boundingRect(with: CGSize.init(width: widthValue, height: CGFloat.greatestFiniteMagnitude),
                                      options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                      attributes: attr as? [NSAttributedStringKey : Any],
                                      context: nil);
        let size = CGSize.init(width: frame.size.width, height: frame.size.height + 1);

        result = max(size.height, result);

        result = CGFloat(ceilf(Float(result)));

        return result;
    }

    @objc class func heightForText(text:NSString, havingWidth widthValue:CGFloat, font:UIFont) -> CGFloat {
        return self.heightForText(text: text, havingWidth: widthValue, font: font, attributes: nil);
    }

}







