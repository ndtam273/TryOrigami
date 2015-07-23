
//
//  RootVC.swift
//  Try Origami
//
//  Created by Tam Nguyen on 7/16/15.
//  Copyright (c) 2015 AST. All rights reserved.
//

import UIKit

class RootVC: MVViewController {
    
    //MARK: Outlet
    @IBOutlet weak var contentContainerView : UIView!
    @IBOutlet weak var tabbarContainerView : UIView!
    
    @IBOutlet weak var viewBarItem1 : UIView!
    @IBOutlet weak var viewBarItem2 : UIView!
    @IBOutlet weak var viewBarItem3 : UIView!
    @IBOutlet weak var viewBarItem4 : UIView!
    
    @IBOutlet weak var btTab1: UIButton!
    @IBOutlet weak var btTab2: UIButton!
    @IBOutlet weak var btTab3: UIButton!
    @IBOutlet weak var btTab4: UIButton!
    
    @IBOutlet weak var lbTab1: UILabel!
    @IBOutlet weak var lbTab2: UILabel!
    @IBOutlet weak var lbTab3: UILabel!
    @IBOutlet weak var lbTab4: UILabel!
    
    @IBOutlet weak var imgTab1: UIImageView!
    @IBOutlet weak var imgTab2: UIImageView!
    @IBOutlet weak var imgTab3: UIImageView!
    @IBOutlet weak var imgTab4: UIImageView!
    
    
    //MARK:  property
    var viewControllers : [AnyObject]?
    var myBoxVC : MyBoxVC?
    var listVideoVC : ListVideoVC?
    var otherVC  : OThersVC?
    var galleryVC : GalleryVC?
    
    var viewIndex = 0
    private var _oldSelectIndex: NSInteger = 0
    
    var selectedViewController: UIViewController? {
        get {
            if(self.selectedIndex != NSNotFound) {
                return self.viewControllers![self.selectedIndex] as? UIViewController;
            } else {
                return nil;
            }
        }
    }
    
    var selectedIndex: NSInteger {
        get {
            return self.selectedIndex
        }
        
        set {
            
            let oldSelectViewController = self.viewControllers![_oldSelectIndex] as? UIViewController
            let newViewController = self.viewControllers![newValue] as? UIViewController
            
            oldSelectViewController?.view.removeFromSuperview()
            
            newViewController?.view.frame = contentContainerView.frame
            var viewSub = newViewController?.view
            self.contentContainerView!.addSubview(viewSub!)
            
            
            
            //save Select
            _oldSelectIndex = newValue;
            
            //reset all button tabbar
            self.resetAllButtonTabbar()
            
            //set button
            self.activeButtonTabbarItem(newValue)
            
        }
    }
    
  
    
    
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configView()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: Class Method
    func configView() {
        // Setup Navigations
        
        //listVideo navigation
        listVideoVC = ListVideoVC(nibName: "ListVideoVC", bundle: nil)
        let listVideoNC : MVNavigationController = MVNavigationController(rootViewController: listVideoVC!)
        //mybox navigation
        myBoxVC = MyBoxVC(nibName: "MyBoxVC", bundle: nil)
        let myBoxNC : MVNavigationController = MVNavigationController(rootViewController: myBoxVC!)
        //gallery navigation
        galleryVC = GalleryVC(nibName: "GalleryVC", bundle: nil)
        let galleryNC : MVNavigationController = MVNavigationController(rootViewController: galleryVC!)
        //other navigation
        otherVC = OThersVC(nibName: "OThersVC", bundle: nil)
        let otherNC : MVNavigationController = MVNavigationController(rootViewController: otherVC!)
        
        self.viewControllers = [listVideoNC,myBoxNC,galleryNC,otherNC]
        
        for vc in viewControllers as! [UIViewController] {
            self.addChildViewController(vc)
            vc.didMoveToParentViewController(self)
        }
        
        self.selectedIndex = 0;

    }
    
    //MARK: Private Method
    private func resetAllButtonTabbar() {
        
        // Reset Image to unselected
        
//        imgTab1.image = UIImage(named: "");
//        imgTab2.image = UIImage(named: "");
//        imgTab3.image = UIImage(named: "");
//        imgTab4.image = UIImage(named: "");
        
        // Reset Tabbar View to unselected
        
        viewBarItem1.backgroundColor = UIColor.clearColor()
        viewBarItem2.backgroundColor = UIColor.clearColor()
        viewBarItem3.backgroundColor = UIColor.clearColor()
        viewBarItem4.backgroundColor = UIColor.clearColor()
        
    }
    
    private func activeButtonTabbarItem(index: NSInteger) {
        //switch index {}
        switch index {
        case 0:
//            imgTab1.image                 = UIImage(named: "")
            viewBarItem1.backgroundColor = UIColor(red: 231/255.0, green: 76/255.0, blue: 60/255.0, alpha: 1)
            break
            
        case 1:
//            imgTab2.image                 = UIImage(named: "")
            viewBarItem2.backgroundColor = UIColor(red: 46/255.0, green: 204/255.0, blue: 113/255.0, alpha: 1)

            break
            
        case 2:
//            imgTab3.image                 = UIImage(named: "")
            viewBarItem3.backgroundColor = UIColor(red: 72/255.0, green: 103/255.0, blue: 165/255.0, alpha: 1)

            break
            
        case 3:
//            imgTab4.image                 = UIImage(named: "")
            viewBarItem4.backgroundColor = UIColor(red: 241/255.0, green: 196/255.0, blue: 15/255.0, alpha: 1)

            break
            
        default:
            break
            
        }
        
    }
    
 //MARK: Action
    // MARK : ACTION
    @IBAction func selectButtonTabbarItem (sender: AnyObject) {
        let button = sender as! UIButton
        viewIndex  = sender.tag
        if (button.tag == _oldSelectIndex) {
            
            if (self.viewControllers![_oldSelectIndex] is UINavigationController) {
                let navi = self.viewControllers![_oldSelectIndex] as! UINavigationController
                navi.popToRootViewControllerAnimated(true)
                
                // send delegate
            }
        } else {
            self.selectedIndex = button.tag
            // send delegate
        }
    }


}
