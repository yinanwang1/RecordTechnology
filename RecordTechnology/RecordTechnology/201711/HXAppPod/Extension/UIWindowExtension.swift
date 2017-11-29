//
//  UIWindowExtension.swift
//  RecordTechnology
//
//  Created by ArthurWang on 2017/11/29.
//  Copyright © 2017年 Monkey King. All rights reserved.
//

import Foundation
import UIKit

extension UIWindow {
    @objc func topVisibleViewController() -> UIViewController {
        let rootViewController = UIWindow.getTopMostViewController();

        return UIWindow.getVisibleViewControllerFrom(vc: rootViewController!);
    }

    fileprivate class func getVisibleViewControllerFrom(vc: UIViewController) -> UIViewController {
        if vc.isKind(of: UINavigationController.self) {
            let visibleVC = (vc as! UINavigationController).visibleViewController;
            return UIWindow.getVisibleViewControllerFrom(vc: visibleVC!);
        } else if vc.isKind(of: UITabBarController.self) {
            let selectedVC = (vc as! UITabBarController).selectedViewController;
            return UIWindow.getVisibleViewControllerFrom(vc:selectedVC!);
        } else {
            if nil == vc.presentedViewController {
                return vc;
            } else {
                return UIWindow.getVisibleViewControllerFrom(vc: vc.presentedViewController!);
            }
        }
    }

    @objc class func getTopMostViewController() -> UIViewController? {
        var window = UIApplication.shared.keyWindow;
        if window?.windowLevel != UIWindowLevelNormal {
            let windows = UIApplication.shared.windows;
            for subWindow in windows {
                if subWindow.windowLevel == UIWindowLevelNormal {
                    window = subWindow;

                    break;
                }
            }
        }

        for subView in (window?.subviews)! {
            var responder = subView.next;

            if (responder?.isEqual(window))! {
                if 0 < subView.subviews.count {
                    let subSubView = subView.subviews[0];

                    responder = subSubView.next;
                }
            }

            if (responder?.isKind(of: UIViewController.self))! {
                return UIWindow.topViewController(controller: responder as! UIViewController);
            }
        }

        return nil;
    }

    fileprivate class func topViewController(controller: UIViewController) -> UIViewController {
        var isPresenting:Bool? = false
        var originalVC = controller;

        repeat {
            let presented = controller.presentedViewController;
            isPresenting = (nil != presented);
            if nil != presented {
                originalVC = presented!;
            }
        } while (isPresenting)!;

        return originalVC;
    }





}
