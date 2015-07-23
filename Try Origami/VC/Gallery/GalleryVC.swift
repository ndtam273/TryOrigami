//
//  GalleryVC.swift
//  Try Origami
//
//  Created by Tam Nguyen on 7/17/15.
//  Copyright (c) 2015 AST. All rights reserved.
//

import UIKit

class GalleryVC: MVViewController,UITableViewDelegate,UITableViewDataSource {
    
    //MARK: Outlet 
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
        return 212
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("GalleryCell") as! GalleryCell!
        
        if (cell == nil) {
            cell = NSBundle.mainBundle().loadNibNamed("GalleryCell", owner: self, options: nil)[0] as! GalleryCell
            
            
        }
        cell.initCell()
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }


   
}
