//
//  NormalViewController.swift
//  RecordTechnology
//
//  Created by ArthurWang on 15/10/9.
//  Copyright © 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

import UIKit

class NormalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "第三页"
        
        self.navigationController?.navigationBar.hidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
