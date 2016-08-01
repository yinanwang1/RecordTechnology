//
//  WebviewViewController.swift
//  RecordTechnology
//
//  Created by ArthurWang on 16/8/1.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

import UIKit
import WebKit


class WebviewViewController: UIViewController, WKUIDelegate, WKNavigationDelegate
{
    
    // MARK: - Property
    
    var wekWebView: WKWebView!
    var linkURLStr: NSString!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialWebView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Initial Methods
    
    func initialWebView() -> Void {
        self.wekWebView = WKWebView.init()
        self.wekWebView.UIDelegate = self
        self.wekWebView.navigationDelegate = self
        self.view.addSubview(self.wekWebView)
        
        self.wekWebView.mas_remakeConstraints { (make:MASConstraintMaker!) -> Void in
            make.edges.mas_equalTo()
        }
        
        self.wekWebView.loadRequest(NSURLRequest.init(URL: NSURL.init(string: "http://www.baidu.com")!))
    }
    
    
    // MARK: - WKUIDelegate
    func webView(webView: WKWebView, createWebViewWithConfiguration configuration: WKWebViewConfiguration, forNavigationAction navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView?
    {
        print(wekWebView)
        print(configuration)
        print(navigationAction)
        print(windowFeatures)
        
        
        return wekWebView
    }
    
    // MARK: - WKNavigationDelegate
    func webView(webView: WKWebView, didCommitNavigation navigation: WKNavigation!) {
        print("navigation \(navigation)")
    }
    

}
