//
//  GalleryCell.swift
//  Try Origami
//
//  Created by Tam Nguyen on 7/20/15.
//  Copyright (c) 2015 AST. All rights reserved.
//

import UIKit

class GalleryCell: UITableViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var whiteView : UIView!
    @IBOutlet weak var modelImg  : UIImageView!
    @IBOutlet weak var modelLb   : UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Method
    func initCell() {
        self.whiteView.layer.cornerRadius = 4;
    }
    
}
