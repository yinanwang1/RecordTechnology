//
//  TableviewSwiftViewController.swift
//  RecordTechnology
//
//  Created by ArthurWang on 16/5/23.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

import UIKit

class TableviewSwiftViewController: UIViewController,
                                    UITableViewDelegate,
                                    UITableViewDataSource
{
    
    var cellIdentifier: String! = "cellIdentifier";
    
    
    // MARK: - Property
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initialTableView();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Initial Methods
    func initialTableView() -> Void {
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.tableView.tableFooterView = UIView.init();
        
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
    }
    

    // Mark: - UITableViewDelegate, UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath);
        
        cell.textLabel?.text = "test"
        
        return cell
    }

}
