//
//  NavigationController.swift
//  LYGankIO
//
//  Created by 韩龙粤 on 16/3/11.
//  Copyright © 2016年 vitasuper. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.barTintColor = UIColor(red:0.84, green:0.64, blue:0.48, alpha:1.0)
        self.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName : UIColor(red:1.0, green:0.96, blue:0.95, alpha:1.0),
                                                NSFontAttributeName: UIFont(name: "Avenir", size: 20)!]

        // Do any additional setup after loading the view.
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
