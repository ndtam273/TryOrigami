//
//  VideoCell.swift
//  Try Origami
//
//  Created by Tam Nguyen on 7/16/15.
//  Copyright (c) 2015 AST. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {
    
    //MARK: Property
    var isAddToBox = false
    
    //MARK: OUTLET
    @IBOutlet weak var  imgVideo: UIImageView!
    @IBOutlet weak var  lblTitle : UILabel!
    @IBOutlet weak var  lblVideoDuration : UILabel!
    @IBOutlet weak var  btnAddtoBox : UIButton!
    @IBOutlet weak var  lblwakaranaiCount : UILabel!
    @IBOutlet weak var  viewWakaranai : UIView!
    @IBOutlet weak var  viewWhite: UIView!
    @IBOutlet weak var  lblAuthor: UILabel!
    
    //MARK: Public Method
    func initCell () {
        
        viewWhite.layer.cornerRadius   = 3
        btnAddtoBox.layer.cornerRadius = 3
        btnAddtoBox.layer.borderWidth  = 2
       
        
        if (isAddToBox == false) {
            btnAddtoBox.setTitle("Add to box", forState: .Normal)
        }else  {
            btnAddtoBox.setTitle("Remove from box", forState: .Normal)
        }
    }
    
    // Action
    @IBAction func changeState (sender: AnyObject) {
        isAddToBox = !isAddToBox
//        self.delegate?.setIsAddtoBox(isAddToBox , cell: self)
        self.initCell()
        
        
    }



}
