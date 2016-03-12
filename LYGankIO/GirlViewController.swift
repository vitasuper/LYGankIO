//
//  GirlViewController.swift
//  LYGankIO
//
//  Created by 韩龙粤 on 16/3/12.
//  Copyright © 2016年 vitasuper. All rights reserved.
//

import UIKit

class GirlViewController: UIViewController {

    @IBOutlet var girlView: UIView!
    @IBOutlet weak var girlImageView: UIImageView!
    var girlImageUrl: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "妹子图"
        
        // Set the background color of the view
        girlView.backgroundColor? = UIColor(red:1.00, green:0.90, blue:0.78, alpha:1.0)
        
        // Settings of the girl imageview
        girlImageView.kf_setImageWithURL(NSURL(string: girlImageUrl)!, placeholderImage: nil)
        girlImageView.layer.masksToBounds = true
        girlImageView.layer.cornerRadius = 10
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
