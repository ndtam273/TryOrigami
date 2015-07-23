//
//  MyBoxVC.swift
//  Try Origami
//
//  Created by Tam Nguyen on 7/16/15.
//  Copyright (c) 2015 AST. All rights reserved.
//

import UIKit

class MyBoxVC: MVViewController,UITableViewDataSource,UITableViewDelegate {
    
    //MARK: OUTLET
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    //MARK: TableView Delegate & DataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 127
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("VideoCell") as! VideoCell!
        
        if (cell == nil) {
            cell = NSBundle.mainBundle().loadNibNamed("VideoCell", owner: self, options: nil)[0] as! VideoCell
            
            
        }
        cell.initCell()
        cell.btnAddtoBox.layer.borderColor  = UIColor(red: 46/255.0, green: 204/255.0, blue: 113/255.0, alpha: 1).CGColor
        cell.btnAddtoBox.setTitleColor(UIColor(red: 46/255.0, green: 204/255.0, blue: 113/255.0, alpha: 1), forState: UIControlState.Normal)
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }


}
