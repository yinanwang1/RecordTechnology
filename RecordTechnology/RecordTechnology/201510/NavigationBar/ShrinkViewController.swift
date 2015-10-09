//
//  ShrinkViewController.swift
//  RecordTechnology
//
//  Created by ArthurWang on 15/10/9.
//  Copyright © 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

import UIKit

class ShrinkViewController: UIViewController, UIScrollViewDelegate  {

    // MARK: - Property
    @IBOutlet weak var shrinkScrollView: UIScrollView!
    var headerView: ShrinkHeaderView?
    var widthConstantOfHeaderView: NSLayoutConstraint?
    
    let MIN_HEIGHT_HEADER_VIEW:CGFloat = 50.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "第二页"
        
        
        self.navigationController?.navigationBar.hidden = true
        
        self.addHeaderViewInScrollView()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.shrinkScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 10000)
        
        self.shrinkScrollView.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func addHeaderViewInScrollView() -> Void {
        
        let views = NSBundle.mainBundle().loadNibNamed("ShrinkHeaderView", owner: self, options: nil)
        
        self.headerView = views.last as? ShrinkHeaderView
        
        self.headerView!.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.headerView!)
        
        self.view.addConstraint(NSLayoutConstraint.init(item: self.headerView!,
            attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.shrinkScrollView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint.init(item: self.headerView!,
            attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.shrinkScrollView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint.init(item: self.headerView!,
            attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.shrinkScrollView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -0))
        self.widthConstantOfHeaderView = NSLayoutConstraint.init(item: self.headerView!,
            attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 100)
        self.view.addConstraint(self.widthConstantOfHeaderView!)
        
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.y + 20.0;
        
        print("scrollView.contentOffset.y is \(offset)")
        
        if ((0 < offset)
            && (offset < MIN_HEIGHT_HEADER_VIEW)) {
                self.headerView?.minorTitleLabel.hidden = true
                
                self.widthConstantOfHeaderView?.constant = 100.0 - offset
                self.headerView?.titleLabel.font = UIFont.systemFontOfSize(27.0 * (100.0 - offset)/100.0)
        } else if 0.0 >= offset {
            self.headerView?.minorTitleLabel.hidden = false
        }
        
        self.headerView?.setNeedsLayout()
    }


}
