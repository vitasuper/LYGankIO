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

class ViewController: UIViewController, GirlImagesDataDelegate {
    
    @IBOutlet weak var GirlTableView: UITableView!
    
    var content: JSON = []
    
    var girlImagesData: [Girl] = []
    
    var historyURL = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delete lines between UITableViewCells
        GirlTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        GirlTableView.dataSource = self
        GirlTableView.delegate = self
        
        GirlTableView.backgroundColor? = UIColor(red:1.00, green:0.90, blue:0.78, alpha:1.0)
        GankIOHttpClient.sharedInstance.girlImagesDataDelegate = self  // Set self as girlImagesDataDelegate

        
        GankIOHttpClient.sharedInstance.catchGirlImagesData()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func girlImagesDataDidReceive(girlJson: JSON) {
        let result = girlJson["results"].arrayValue
        for item in result {
            let girl = Girl(girlJson: item)
            girlImagesData.append(girl)
        }
        GirlTableView.reloadData()
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
        cell.setGirlImageAction(self, action: Selector("girlImageTapped:"))
        
        let index = girlItem.publishedAt.startIndex.advancedBy(10)
        cell.dateLabel.text = girlItem.publishedAt.substringToIndex(index)
        
//        let post = data[indexPath.row]
//        cell.postImageView.image = UIImage(named: post.image)
//
//        
//        cell.avatarImageView.image = UIImage(named: post.avatar)
//        
//        cell.usernameLabel.text = post.username
//        
//        cell.nicknameLabel.text = post.nickname
//        
//        cell.contentLabel.text = post.content
//        
//        cell.timeLabel.text = post.created_at
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return girlImagesData.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let cell = tableView.cellForRowAtIndexPath(indexPath)
//        
//        normalText = cell?.textLabel?.text
//        
//        performSegueWithIdentifier("", sender: nil)
    }
    
    // Action for tapping the girl image
    func girlImageTapped(sender: UITapGestureRecognizer) {
        // Your action
        print("hahaha")
    }






}






