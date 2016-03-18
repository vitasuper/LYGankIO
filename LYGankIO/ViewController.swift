//
//  ViewController.swift
//  LYGankIO
//
//  Created by 韩龙粤 on 16/3/10.
//  Copyright © 2016年 vitasuper. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import MJRefresh

class ViewController: UIViewController, GirlImagesDataDelegate {
    
    @IBOutlet weak var GirlTableView: UITableView!
    
    var girlImagesData: [Girl] = []
    var girlImageUrl: String = ""
    var pageNo: Int = 1
    var loadMoreFlag: Bool = false
    var selectedDate: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delete lines between UITableViewCells
        GirlTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        GirlTableView.dataSource = self
        GirlTableView.delegate = self
        
        GirlTableView.backgroundColor? = UIColor(red:1.00, green:0.90, blue:0.78, alpha:1.0)
        GankIOHttpClient.sharedInstance.girlImagesDataDelegate = self  // Set self as girlImagesDataDelegate
        
        // Settings of the MJRefresh
        GirlTableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "headerRefresh")
        GirlTableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: "footerRefresh")
        
        // Start catching the GankIO girl images
        GankIOHttpClient.sharedInstance.catchGirlImagesData(1)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func girlImagesDataDidReceive(girlJson: JSON) {
        if loadMoreFlag {
            let result = girlJson["results"].arrayValue
            if result.count < 10 {
                GirlTableView.mj_footer.endRefreshingWithNoMoreData()
                pageNo -= 1
            }
            for item in result {
                let girl = Girl(girlJson: item)
                girlImagesData.append(girl)
            }
            GirlTableView.mj_footer.endRefreshing()
        } else {
            let result = girlJson["results"].arrayValue
            for item in result {
                let girl = Girl(girlJson: item)
                girlImagesData.append(girl)
            }
            GirlTableView.mj_header.endRefreshing()
        }

        GirlTableView.reloadData()
    }
    
    func headerRefresh() {
//        delay(2) { () -> () in
            self.girlImagesData.removeAll(keepCapacity: false)
            self.pageNo = 1
            self.loadMoreFlag = false
            GankIOHttpClient.sharedInstance.catchGirlImagesData(self.pageNo)
//        }
    }
    
    func footerRefresh() {
//        delay(2) { () -> () in
            self.pageNo += 1
            self.loadMoreFlag = true
            GankIOHttpClient.sharedInstance.catchGirlImagesData(self.pageNo)
//        }
    }
    
    
    // Delay method
    func delay(time:Double,closure:() -> ()){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let girlItem = girlImagesData[indexPath.row]
        
        // Some settings of the cell, such as properties, methods for events and so on
        let cell = tableView.dequeueReusableCellWithIdentifier("GirlCell", forIndexPath: indexPath) as! GirlCell
        
        cell.setGirlImage(girlItem)
        cell.setGirlImageAction(indexPath, target: self, action: Selector("girlImageTapped:"))
        
        
        let index = girlItem.publishedAt.startIndex.advancedBy(10)
        cell.dateLabel.text = girlItem.publishedAt.substringToIndex(index)
        cell.whoLabel.text = "供图者：" + girlItem.who
        
        return cell
        
    }
    
    // Return the number of the table view cell
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return girlImagesData.count
    }

    
    // Action for tapping the girl image
    func girlImageTapped(sender: UITapGestureRecognizer) {
        // Your action
        let girlImageView = sender.view as! UIImageView
        girlImageUrl = girlImagesData[girlImageView.tag].url
        performSegueWithIdentifier("showGirlViewController", sender: nil)
    }
    
    // Action for tapping the cell to view the daily gank
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let index = girlImagesData[indexPath.row].publishedAt.startIndex.advancedBy(10)
        selectedDate = girlImagesData[indexPath.row].publishedAt.substringToIndex(index).stringByReplacingOccurrencesOfString("-", withString: "/", options: NSStringCompareOptions.LiteralSearch, range: nil)
        // print(selectedDate)
        performSegueWithIdentifier("showDailyGankController", sender: nil)
    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Hide the word of the back button of the navigation bar
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        if segue.identifier == "showGirlViewController" {
            let girlViewController = segue.destinationViewController as! GirlViewController
            girlViewController.girlImageUrl = girlImageUrl
        } else if segue.identifier == "showDailyGankController" {
            let dailyGankViewController = segue.destinationViewController as! DailyGankViewController
            dailyGankViewController.selectedDate = selectedDate
        }
    }
    

//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let cell = tableView.cellForRowAtIndexPath(indexPath)
//        
//        normalText = cell?.textLabel?.text
//        
//        performSegueWithIdentifier("showNormalViewController", sender: nil)
//    }
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "showNormalViewController" {
//            let viewController = segue.destinationViewController as! NormalViewController
//            
//            viewController.normalText = normalText
//        }
//    }
//



}






