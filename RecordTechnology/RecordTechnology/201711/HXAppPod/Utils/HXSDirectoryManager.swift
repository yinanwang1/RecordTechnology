//
//  HXSDirectoryManager.swift
//  RecordTechnology
//
//  Created by ArthurWang on 2017/11/27.
//  Copyright © 2017年 Monkey King. All rights reserved.
//

import Foundation

class HXSDirectoryManager: NSObject {
    @objc class func getLibraryDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true);
        let libraryDirectory = paths[0];

        return libraryDirectory;
    }

    @objc class func getCachesDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true);
        let cachesDirectory = paths[0];

        return cachesDirectory;
    }

    @objc class func getDocumentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true);
        let documentsDirectory = paths[0];

        return documentsDirectory;
    }

    @objc class func getTempDirectory() -> String {
        return NSTemporaryDirectory();
    }





    @objc class func enumarateDirectoryAtPath(path:String, inCaches:Bool) -> NSArray? {
        var enumPath:String? = nil;

        if inCaches {
            let cachesDir = self.getCachesDirectory() as NSString;
            enumPath = cachesDir.appendingPathComponent(path);
        } else {
            enumPath = String.init(path);
        }

        if nil == enumPath {
            return nil;
        }

        do {
            let enumArray = try FileManager.default.contentsOfDirectory(atPath: enumPath!);

            return enumArray as NSArray;
        } catch {
            return nil;
        }
    }

    @objc class func createDirectoryAtPath(path:String) -> Bool {
        if FileManager.default.fileExists(atPath: path) {
            return false;
        } else {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: false, attributes: nil);
            } catch {
                return false;
            }

            return true;
        }
    }

    @objc class func createDirectoryAtCachesWithName(dirName:String) -> Bool {
        let path = self.getCachesDirectory() as NSString;
        let dirPath = path.appendingPathComponent(dirName);

        return self.createDirectoryAtPath(path: dirPath);
    }

    @objc class func moveFilesFrom(fromFile:String, toFile:String) {
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: fromFile);

            if 0 < files.count {
                for selectedFile in files {
                    let fromFilePath = (fromFile as NSString).appendingPathComponent(selectedFile);
                    let toFilePath = (toFile as NSString).appendingPathComponent(selectedFile);

                    let isDir = UnsafeMutablePointer<ObjCBool>.allocate(capacity: 1);
                    if FileManager.default.fileExists(atPath: fromFilePath, isDirectory:isDir) {
                        if isDir.pointee.boolValue {
                            do {
                                try FileManager.default.createDirectory(atPath: toFilePath, withIntermediateDirectories: false, attributes: nil);
                                self.moveFilesFrom(fromFile: fromFilePath, toFile: toFilePath);
                            } catch {
                                // Do nothing
                            }
                        } else {
                            do {
                                try FileManager.default.moveItem(atPath: fromFilePath, toPath: toFilePath);
                            } catch {
                                // Do nothing
                            }
                        }
                    }
                }
            }
        } catch {
            // Do nothing
        }
    }

    @objc class func addSkipBackupAttributeToItemAtURL(URL:NSURL?) -> Bool {
        if nil == URL {
            return false;
        }

        assert(FileManager.default.fileExists(atPath: (URL?.path)!));

        do {
            try URL?.setResourceValue(NSNumber.init(value: true), forKey: URLResourceKey.isExcludedFromBackupKey);

            return true;
        } catch {
            return false;
        }
    }

    @objc class func getAdImagePath(image_url:String) -> String {
        var imagePath = self.getCachesDirectory();
        imagePath = (imagePath as NSString).appendingPathComponent("LaunchAd");
        if !(FileManager.default.fileExists(atPath: imagePath, isDirectory: nil)) {
            _ = self.createDirectoryAtPath(path: imagePath);
        }

        imagePath = (imagePath as NSString).appending(NSString.md5(image_url));

        return imagePath;
    }

}







