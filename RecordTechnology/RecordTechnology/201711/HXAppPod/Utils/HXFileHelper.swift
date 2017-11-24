//
//  HXFileHelper.swift
//  RecordTechnology
//
//  Created by ArthurWang on 2017/11/24.
//  Copyright © 2017年 Monkey King. All rights reserved.
//

import Foundation

class HXFileHelper: NSObject {

    static let HX_DATA_PATH:String = "HXData";

    @objc class func absolutePathForDataFile(fileName: String) -> String? {

        let dirs = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true);
        if 0 == dirs.count {
            return nil;
        }

        let path = (dirs[0] as NSString).appendingPathComponent(HX_DATA_PATH);
        if (FileManager.default.fileExists(atPath: path)) {
            return (path as NSString).appendingPathComponent(fileName);
        } else {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil);

                return (path as NSString).appendingPathComponent(fileName);
            } catch {
                return nil;
            }
        }
    }

    @objc class func existsDataFile(fileName: String) -> Bool {
        let path = self.absolutePathForDataFile(fileName: fileName);

        if nil == path {
            return false;
        }

        return FileManager.default.fileExists(atPath: path!);
    }

    @objc class func writeDataFile(fileName: String, data: NSData) {
        let absFile = self.absolutePathForDataFile(fileName: fileName);

        if nil == absFile {
            return;
        }

        data.write(toFile: absFile!, atomically: true);
    }

    @objc class func absolutePathForDocumentFile(docFile: String) -> String? {
        let dirs = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true);
        if 0 == dirs.count {
            return nil;
        }

        return (dirs[0] as NSString).appendingPathComponent(docFile);
    }

    @objc class func writeDocumentFile(fileName: String, data: NSData) {
        let absFile = self.absolutePathForDocumentFile(docFile: fileName);

        if nil == absFile {
            return;
        }

        data.write(toFile: absFile!, atomically: true);
    }

    @objc class func existsDocumentFile(fileName: String) -> Bool {
        let path = self.absolutePathForDocumentFile(docFile: fileName);

        if nil == path {
            return false;
        }

        return FileManager.default.fileExists(atPath:path!);
    }



}
