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


class Girl {
    let updatedAt:String
    let who:String
    let publishedAt:String
    let objectId:String
    let used:Bool
    let type:String
    let createdAt:String
    let desc:String
    let url:String
    
    init(item: JSON){
        updatedAt = item["updateAt"].stringValue
        who = item["who"].stringValue
        objectId = item["objectId"].stringValue
        publishedAt = item["publishedAt"].stringValue
        used = item["used"].boolValue
        createdAt = item["createdAt"].stringValue
        url = item["url"].stringValue
        desc = item["desc"].stringValue
        type = item["type"].stringValue
    }
}


class ViewController: UIViewController {
    
    var content: JSON = []
    
    var girlsData: [Girl] = []
    
    var historyURL = String()
    
    @IBOutlet weak var GankIOTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GankIOTableView.dataSource = self
        GankIOTableView.delegate = self
        
        historyURL = ("http://gank.io/api/data/福利/10/1").stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        fetchGirlsData()
//        Alamofire.request(.GET, historyURL).validate().responseJSON { response in
//            switch response.result {
//            case .Success:
//                if let value = response.result.value {
//                    let json = JSON(value)
//                    print("JSON: \(json)")
//                    self.content = json
//                    self.testFunc(json)
//                }
//            case .Failure(let error):
//                print(error)
//            }
//        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchGirlsData() {
        Alamofire.request(.GET, historyURL).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("haha")
                    self.girlsDataReceived(json)
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    func girlsDataReceived(json: JSON) {
        let result = json["results"].arrayValue
        for item in result {
            let girl = Girl(item: item)
            girlsData.append(girl)
        }
        GankIOTableView.reloadData()
    }
    
    func testFunc(json: JSON) {
        let picURL = json["results"][0]["url"].stringValue
        print(picURL)
        //        testImage.kf_setImageWithURL(NSURL(string: picURL)!, placeholderImage: nil)
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
        let girlItem = girlsData[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("GankIOCell", forIndexPath: indexPath) as! GankIOCell
        
        // cell.girlImageView.kf_setImageWithURL(NSURL(string: content["results"][0]["url"].stringValue)!, placeholderImage: nil)
        cell.setGirlImage(girlItem)
        cell.dateLabel.text = "ci"
        
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
        return girlsData.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let cell = tableView.cellForRowAtIndexPath(indexPath)
//        
//        normalText = cell?.textLabel?.text
//        
//        performSegueWithIdentifier("", sender: nil)
    }
}













