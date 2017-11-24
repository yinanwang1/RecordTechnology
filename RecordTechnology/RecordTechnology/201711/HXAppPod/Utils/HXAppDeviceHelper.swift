//
//  HXAppDeviceHelper.swift
//  Dispatch
//
//  Created by ArthurWang on 2017/11/21.
//  Copyright © 2017年 骑迹. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

enum HXDeviceModel {
    case HXDeviceUnknown

    case HXDeviceSimulator
    case HXDeviceSimulatoriPhone
    case HXDeviceSimulatoriPad
    case HXDeviceSimulatorAppleTV

    case HXDevice1GiPhone
    case HXDevice3GiPhone
    case HXDevice3GSiPhone
    case HXDevice4iPhone
    case HXDevice4SiPhone
    case HXDevice5iPhone
    case HXDevice5CiPhone
    case HXDevice5SiPhone

    case HXDevice1GiPod
    case HXDevice2GiPod
    case HXDevice3GiPod
    case HXDevice4GiPod
    case HXDevice5GiPod//15

    case HXDevice1GiPad
    case HXDevice2GiPad
    case HXDevice3GiPad
    case HXDevice4GiPad
    case HXDeviceMiniPad
    case HXDeviceiPadAir
    case HXDeviceMiniPad2G

    case HXDeviceAppleTV2
    case HXDeviceAppleTV3
    case HXDeviceAppleTV4

    case HXDeviceUnknowniPhone
    case HXDeviceUnknowniPod
    case HXDeviceUnknowniPad
    case HXDeviceUnknownAppleTV
    case HXDeviceIFPGA

    case HXDevice6iPhone
    case HXDevice6PlusiPhone
    case HXDevice6siPhone
    case HXDevice6sPlusiPhone
    case HXDevice7iPhone
    case HXDevice7PluseIPhone
    case HXDevice8iPhone
    case HXDevice8PlusiPhone
    case HXDeviceXiPhone
}

enum HXDeviceFamily {
    case HXDeviceFamilyiPhone
    case HXDeviceFamilyiPod
    case HXDeviceFamilyiPad
    case HXDeviceFamilyAppleTV
    case HXDeviceFamilyUnknown
}




class HXAppDeviceHelper: NSObject {

    @objc class func isDeviceIPad() -> Bool {
        return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad;
    }

    @objc class func isDeviceIPhone() -> Bool {
        return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone;
    }

    @objc class func deviceHasRetinaScreen() -> Bool {
        return UIScreen.main.scale >= 2.0;
    }

    @objc class func iosVersion() -> String {
        return UIDevice.current.systemVersion;
    }

    /*
     Platforms

     iFPGA ->        ??

     iPhone1,1 ->    iPhone 1G, M68
     iPhone1,2 ->    iPhone 3G, N82
     iPhone2,1 ->    iPhone 3GS, N88
     iPhone3,1 ->    iPhone 4/AT&T, N89
     iPhone3,2 ->    iPhone 4/Other Carrier?, ??
     iPhone3,3 ->    iPhone 4/Verizon, TBD
     iPhone4,1 ->    (iPhone 4S/GSM), TBD
     iPhone4,2 ->    (iPhone 4S/CDMA), TBD
     iPhone4,3 ->    (iPhone 4S/???)
     iPhone5,1 ->    iPhone Next Gen, TBD
     iPhone5,1 ->    iPhone Next Gen, TBD
     iPhone5,1 ->    iPhone Next Gen, TBD

     iPod1,1   ->    iPod touch 1G, N45
     iPod2,1   ->    iPod touch 2G, N72
     iPod2,2   ->    Unknown, ??
     iPod3,1   ->    iPod touch 3G, N18
     iPod4,1   ->    iPod touch 4G, N80

     // Thanks NSForge
     iPad1,1   ->    iPad 1G, WiFi and 3G, K48
     iPad2,1   ->    iPad 2G, WiFi, K93
     iPad2,2   ->    iPad 2G, GSM 3G, K94
     iPad2,3   ->    iPad 2G, CDMA 3G, K95
     iPad3,1   ->    (iPad 3G, WiFi)
     iPad3,2   ->    (iPad 3G, GSM)
     iPad3,3   ->    (iPad 3G, CDMA)
     iPad4,1   ->    (iPad 4G, WiFi)
     iPad4,2   ->    (iPad 4G, GSM)
     iPad4,3   ->    (iPad 4G, CDMA)

     AppleTV2,1 ->   AppleTV 2, K66
     AppleTV3,1 ->   AppleTV 3, ??

     i386, x86_64 -> iPhone Simulator
     */

    // MARK: - platform type and name utils
    class func modelType() -> HXDeviceModel {
        let platform = self.platform();
        if (platform.hasPrefix("iPhone3")) {return HXDeviceModel.HXDevice4iPhone;}
        if (platform.hasPrefix("iPhone4")) {return HXDeviceModel.HXDevice4SiPhone;}
        if (platform == "iPhone5,1") {return HXDeviceModel.HXDevice5iPhone}
        if (platform == "iPhone5,2") {return HXDeviceModel.HXDevice5iPhone}
        if (platform == "iPhone5,3") {return HXDeviceModel.HXDevice5CiPhone}
        if (platform == "iPhone5,4") {return HXDeviceModel.HXDevice5CiPhone}
        if (platform.hasPrefix("iPhone6")) {return HXDeviceModel.HXDevice5SiPhone;}
        if (platform == "iPhone7,1") {return HXDeviceModel.HXDevice6PlusiPhone}
        if (platform == "iPhone7,2") {return HXDeviceModel.HXDevice6iPhone}
        if (platform == "iPhone8,1") {return HXDeviceModel.HXDevice6siPhone}
        if (platform == "iPhone8,2") {return HXDeviceModel.HXDevice6sPlusiPhone}
        if (platform == "iPhone9,1") {return HXDeviceModel.HXDevice7iPhone}
        if (platform == "iPhone9,2") {return HXDeviceModel.HXDevice7PluseIPhone}
        if (platform == "iPhone9,3") {return HXDeviceModel.HXDevice7iPhone}
        if (platform == "iPhone9,4") {return HXDeviceModel.HXDevice7PluseIPhone}
        if (platform == "iPhone10,1") {return HXDeviceModel.HXDevice8iPhone}
        if (platform == "iPhone10,2") {return HXDeviceModel.HXDevice8PlusiPhone}
        if (platform == "iPhone10,3") {return HXDeviceModel.HXDeviceXiPhone}
        if (platform == "iPhone10,4") {return HXDeviceModel.HXDevice8iPhone}
        if (platform == "iPhone10,5") {return HXDeviceModel.HXDevice8PlusiPhone}
        if (platform == "iPhone10,6") {return HXDeviceModel.HXDeviceXiPhone}

        if (platform.hasPrefix("86") || platform == "x86_64") {
            let smallerScreen = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) < 768;

            return smallerScreen ? HXDeviceModel.HXDeviceSimulatoriPhone : HXDeviceModel.HXDeviceSimulatoriPad;
        }

        return HXDeviceModel.HXDeviceUnknown;
    }

    @objc class func modelTypeString() -> String {
        let deviceModel = HXAppDeviceHelper.modelType();
        var deviceModelString = "Unknown";
        switch deviceModel {
        case .HXDeviceSimulator: deviceModelString = "iOS Simulator";
        case .HXDeviceSimulatoriPhone: deviceModelString = "iPhone Simulator";
        case .HXDeviceSimulatoriPad: deviceModelString = "iPad Simulator";
        case .HXDevice4iPhone: deviceModelString = "iPhone 4";
        case .HXDevice4SiPhone: deviceModelString = "iPhone 4S";
        case .HXDevice5iPhone: deviceModelString = "iPhone 5";
        case .HXDevice5CiPhone: deviceModelString = "iPhone 5C";
        case .HXDevice5SiPhone: deviceModelString = "iPhone 5S";
        case .HXDevice6iPhone: deviceModelString = "iPhone 6";
        case .HXDevice6PlusiPhone: deviceModelString = "iPhone 6 Plus";
        case .HXDevice6siPhone: deviceModelString = "iPhone 6S";
        case .HXDevice6sPlusiPhone: deviceModelString = "iPhone 6S Plus";
        case .HXDevice7iPhone: deviceModelString = "iPhone 7";
        case .HXDevice7PluseIPhone: deviceModelString = "iPhone 7 Plus";
        case .HXDevice8iPhone: deviceModelString = "iPhone 8";
        case .HXDevice8PlusiPhone: deviceModelString = "iPhone 8 Plus";
        case .HXDeviceXiPhone: deviceModelString = "iPhone X";
        default:deviceModelString = self.platform();
        }

        return deviceModelString;
    }

    @objc class func modelString() -> String {
        let model = self.platform()
        return model;
    }



    // MARK: - sysctlbyname utils
    fileprivate class func getSysInfoByName(typeSepcifier:String) -> String {
        var size:size_t = 0;
        sysctlbyname(typeSepcifier.cString(using: String.Encoding.utf8), nil, &size, nil, 0);

        let answer = UnsafeMutablePointer<CChar>.allocate(capacity: size);
        sysctlbyname(typeSepcifier.cString(using: String.Encoding.utf8), answer, &size, nil, 0);

        let results = String.init(cString: answer);

        free(answer);

        return results;
    }

    fileprivate class func platform() -> String {
        return self.getSysInfoByName(typeSepcifier: "hw.machine");
    }

    fileprivate class func hwmodel() -> String {
        return self.getSysInfoByName(typeSepcifier: "hw.model");
    }

    // MARK: - sysctl utils
    fileprivate class func getSysInfo(typeSpecifier:Int32) -> Int {
        var size:size_t = MemoryLayout<Int>.size;
        var results:Int = 0;
        let mib = UnsafeMutablePointer<Int32>.allocate(capacity: 2);
        mib[0] = CTL_HW;
        mib[1] = typeSpecifier;
        sysctl(mib, 2, &results, &size, nil, 0);

        return results;
    }

    @objc class func cpuFrequency() -> Int {
        return self.getSysInfo(typeSpecifier: HW_CPU_FREQ);
    }

    @objc class func busFrequency() -> Int {
        return self.getSysInfo(typeSpecifier: HW_BUS_FREQ);
    }

    @objc class func cpuCount() -> Int {
        return self.getSysInfo(typeSpecifier: HW_NCPU);
    }

    @objc class func totalMemory() -> Int {
        return self.getSysInfo(typeSpecifier: HW_PHYSMEM);
    }

    @objc class func userMemory() -> Int {
        return self.getSysInfo(typeSpecifier: HW_USERMEM);
    }

    @objc class func maxSocketBufferSize() -> Int {
        return self.getSysInfo(typeSpecifier: KIPC_MAXSOCKBUF);
    }


    // MARK: - file system

    @objc class func totalDiskSpace() -> NSNumber {
        do {
            let fattributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory());

            return fattributes[FileAttributeKey.systemSize] as! NSNumber;
        } catch {
            print("Error");
        }

        return NSNumber.init(value: 0);
    }

    @objc class func freeDiskSpace() -> NSNumber {
        do {
            let fattributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory());

            return fattributes[FileAttributeKey.systemFreeSize] as! NSNumber;
        } catch {
            print("Error");
        }

        return NSNumber.init(value: 0);
    }

    @objc class func deviceFamily() -> Int {
        let platform = self.platform();
        if (platform.hasPrefix("iPhone")) {return 0;}
        if (platform.hasPrefix("iPod")) {return 1;}
        if (platform.hasPrefix("iPad")) {return 2;}
        if (platform.hasPrefix("AppleTV")) {return 3;}

        return -1;
    }

    static var defaultRouteReachability:SCNetworkReachability? = nil;
    @objc class func isInternetConnectionAvailable() -> Bool {
        if (nil == defaultRouteReachability) {
            var zeroAddress = sockaddr(sa_len: 0, sa_family: 0, sa_data: (0,0,0,0,0,0,0,0,0,0,0,0,0,0))
            zeroAddress.sa_len = __uint8_t(MemoryLayout<sockaddr_in>.size);
            zeroAddress.sa_family = sa_family_t(AF_INET);
            defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(nil, &zeroAddress);
        }

        var flags:SCNetworkReachabilityFlags = SCNetworkReachabilityFlags.isDirect;
        if (false == SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags)) {
            return false;
        }

        if (0 == (flags.rawValue & SCNetworkReachabilityFlags.reachable.rawValue)) {
            return false;
        }

        if (0 == (flags.rawValue & SCNetworkReachabilityFlags.connectionRequired.rawValue)) {
            return true;
        }

        if ((0 != (flags.rawValue & SCNetworkReachabilityFlags.connectionOnDemand.rawValue))
            || (0 != (flags.rawValue & SCNetworkReachabilityFlags.connectionOnTraffic.rawValue))) {
            if (0 == (flags.rawValue & SCNetworkReachabilityFlags.interventionRequired.rawValue)) {
                return true;
            }
        }

        return false;
    }

    @objc class func uniqueDeviceIdentifier() -> String {
        let appName = Bundle.main.infoDictionary!["CFBundleDisplayName"];
        var identifier = SAMKeychain.password(forService: appName as! String, account: "uniqueDeviceIdentifier", error: nil);

        if (nil != identifier) {
            return identifier!;
        } else {
            identifier = "o" + (UIDevice.current.identifierForVendor?.uuidString)!;
            SAMKeychain.setPassword(identifier!, forService: appName as! String, account: "uniqueDeviceIdentifier");

            return identifier!;
        }

    }

    @objc class func currentLocaleId() -> String {
        let str = NSLocale.current.identifier;

        let range = str.range(of: "@");
        if (nil == range
            || range?.lowerBound == str.startIndex) {
            return str;
        } else {
            return String(str[..<(range?.lowerBound)!]);
        }
    }

    @objc class func currentScreenSize() -> CGSize {
        return UIScreen.main.bounds.size;
    }

    @objc class func isScreen480Height() -> Bool {
        let result = fabs(max(self.currentScreenSize().width, self.currentScreenSize().height) - 480);
        return result < 0.001;
    }

    @objc class func isScreen568Height() -> Bool {
        let result = fabs(max(self.currentScreenSize().width, self.currentScreenSize().height) - 568);
        return result < 0.001;
    }

    @objc class func isScreenMoreThanOrEqualTo568Height() -> Bool {
        let result = fabs(max(self.currentScreenSize().width, self.currentScreenSize().height) - 568);
        return result >= 0;
    }

    @objc class func isScreen667Height() -> Bool {
        let result = fabs(max(self.currentScreenSize().width, self.currentScreenSize().height) - 667);
        return result < 0.001;
    }

    @objc class func isScreen736Height() -> Bool {
        let result = fabs(max(self.currentScreenSize().width, self.currentScreenSize().height) - 736);
        return result < 0.001;
    }

    @objc class func isIPhone6() -> Bool {
        return self.modelType() == HXDeviceModel.HXDevice6iPhone;
    }

    @objc class func isIPhone6Plus() -> Bool {
        return self.modelType() == HXDeviceModel.HXDevice6PlusiPhone;
    }

    @objc class func isJailbroken() -> Bool {
        var isJailbroken = false;
        let cydiaPath = "/Applications/Cydia.app";
        let aptPath = "/private/var/lib/apt/";

        if (FileManager.default.fileExists(atPath: cydiaPath)) {
            isJailbroken = true;
        }

        if FileManager.default.fileExists(atPath: aptPath) {
            isJailbroken = true;
        }

        return isJailbroken;
    }

}







