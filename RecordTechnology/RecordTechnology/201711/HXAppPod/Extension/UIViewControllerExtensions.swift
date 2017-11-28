//
//  UIViewControllerExtensions.swift
//  RecordTechnology
//
//  Created by ArthurWang on 2017/11/28.
//  Copyright © 2017年 Monkey King. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    @objc func topMostViewController() -> UIViewController? {
        if nil == self.presentedViewController {
            return self;
        } else if self.presentedViewController is UINavigationController {
            let navigationController = self.presentedViewController as! UINavigationController;
            let lastViewController = navigationController.viewControllers.last;

            return lastViewController?.topMostViewController();
        }

        return self.presentedViewController?.topMostViewController();
    }

    @objc class func controllerFromXib() -> UIViewController {
        return self.init(nibName: String(describing:self), bundle: nil);
    }

    @objc class func controllerFromXibWithModuleName(moduleNameStr: String) -> UIViewController {
        var bundle = Bundle(for: self);
        let bundlePath = bundle.path(forResource: moduleNameStr, ofType: "bundle");
        if nil != bundlePath {
            bundle = Bundle.init(path: bundlePath!)!;
        }

        return self.init(nibName: String(describing:self), bundle: bundle);
    }

    @objc func back() {
        if 1 == self.navigationController?.viewControllers.count {
            self.presentedViewController?.dismiss(animated: true, completion: nil);
        } else {
            self.navigationController?.popViewController(animated: true);
        }
    }

    @objc func backToController(ctrlClassName:String) {
        let module = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String;

        if nil != self.navigationController {
            let controllers = self.navigationController?.viewControllers;

            for vc in controllers! {
                let targetVC = NSClassFromString(module + "." + ctrlClassName) as! UIViewController.Type;

                if vc.isKind(of: targetVC) {
                    self.navigationController?.popToViewController(vc, animated: true);

                    return;
                }
            }
        }
    }

    @objc func backToControllerBeforeController(ctrlClassName: String) {
        let module = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String;
        var specifiedVC:UIViewController? = nil;

        if nil != self.navigationController {
            let controllers = self.navigationController?.viewControllers;

            for vc in controllers! {
                let targetVC = NSClassFromString(module + "." + ctrlClassName) as! UIViewController.Type;

                if vc.isKind(of: targetVC) {
                    specifiedVC = vc;

                    break;
                }
            }
        }

        if nil != specifiedVC {
            let vcs:NSArray = (self.navigationController?.viewControllers)! as NSArray;
            let index = vcs.index(of: specifiedVC!);
            if 0 < index {
                let prevCtrl = vcs.object(at: index - 1) as! UIViewController;
                self.navigationController?.popToViewController(prevCtrl, animated: true);
            } else {
                self.navigationController?.popToViewController(specifiedVC!, animated: true);
            }
        }
    }




}
