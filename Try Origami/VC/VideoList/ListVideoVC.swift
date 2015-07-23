//
//  ListVideoVC.swift
//  Try Origami
//
//  Created by Tam Nguyen on 7/16/15.
//  Copyright (c) 2015 AST. All rights reserved.
//

import UIKit

class ListVideoVC: MVViewController,UITableViewDataSource, UITableViewDelegate {
    //MARK: Property
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
        cell.btnAddtoBox.layer.borderColor  = UIColor(red: 231/255.0, green: 76/255.0, blue: 60/255.0, alpha: 1).CGColor
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    
}
