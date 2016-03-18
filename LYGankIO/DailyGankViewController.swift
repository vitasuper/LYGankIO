//
//  DailyGankViewController.swift
//  LYGankIO
//
//  Created by 韩龙粤 on 16/3/17.
//  Copyright © 2016年 vitasuper. All rights reserved.
//

import SwiftyJSON
import SafariServices
import UIKit

class DailyGankViewController: UIViewController, DailyGankDataDelegate {
    @IBOutlet weak var DailyGankTableView: UITableView!

    var selectedDate: String = ""
    var dailyGankData: [DailyGank] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DailyGankTableView.dataSource = self
        DailyGankTableView.delegate = self
        
        // Set the dailyGankDataDelegate of the GankIOHttpClient
        GankIOHttpClient.sharedInstance.dailyGankDataDelegate = self
        // Start catching the data of dailyGankIO
        GankIOHttpClient.sharedInstance.catchDailyGankData(selectedDate)
        
        title = "干货 \(selectedDate)"
        DailyGankTableView.backgroundColor? = UIColor(red:1.00, green:0.90, blue:0.78, alpha:1.0)
        // Delete lines between UITableViewCells
        DailyGankTableView.separatorStyle = UITableViewCellSeparatorStyle.None

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func DailyGankDataDidReceive(dailyGankJson: JSON) {
        
        // Remember to remove all items of the dailyGankData first
        dailyGankData.removeAll()
        
        // Add every gank item in the dailyGankData
        let category = dailyGankJson["category"].arrayValue
        let results = dailyGankJson["results"]
        for item in category {
            if item.stringValue != "福利" {
                let dailyGanks = results[item.stringValue].arrayValue
                for dailyGank in dailyGanks {
                    dailyGankData.append(DailyGank(dailyGankJson: dailyGank))
                }
            }
        }
        DailyGankTableView.reloadData()
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

extension DailyGankViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let gankItem = dailyGankData[indexPath.row]
        
        // Some settings of the cell, such as properties, methods for events and so on
        let cell = tableView.dequeueReusableCellWithIdentifier("DailyGankCell", forIndexPath: indexPath) as! DailyGankCell
        cell.typeLabel.text = gankItem.type
        cell.descLabel.text = gankItem.desc
        
        
        return cell
        
    }

    // Return the number of the table view cell
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyGankData.count
    }

    // Action for tapping the cell to view the gank content
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // The url may contain some Chinese character
        let gankContentUrl = dailyGankData[indexPath.row].url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        let safariView = SFSafariViewController(URL: NSURL(string: gankContentUrl)!)
        presentViewController(safariView, animated: true, completion: nil)
    }
}
