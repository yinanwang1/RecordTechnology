//
//  SearchViewController.swift
//  RecordTechnology
//
//  Created by ArthurWang on 16/8/1.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Property
    @IBOutlet weak var URLTextView: UITextView!
    
    var webviewController: WebviewViewController!
    
    
    // MARK: - Lifes Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        webviewController.linkURLStr
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
    
    // MARK: - Action Methods

}
