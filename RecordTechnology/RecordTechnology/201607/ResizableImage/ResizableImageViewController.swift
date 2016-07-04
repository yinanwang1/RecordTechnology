//
//  ResizableImageViewController.swift
//  RecordTechnology
//
//  Created by ArthurWang on 16/7/4.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

import UIKit

class ResizableImageViewController: UIViewController {
    
    @IBOutlet weak var resizableImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let image = UIImage.init(named: "filterIcon");
        let newImage = image?.resizableImageWithCapInsets(UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5), resizingMode:UIImageResizingMode.Tile)
        
        resizableImageView.image = newImage;
        
        
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
