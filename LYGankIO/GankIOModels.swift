//
//  GankIOModels.swift
//  LYGankIO
//
//  Created by 韩龙粤 on 16/3/10.
//  Copyright © 2016年 vitasuper. All rights reserved.
//

import SwiftyJSON

class Girl {
    let _id: String
    let desc: String
    let publishedAt: String
    let type: String
    let url: String
    let used: Bool
    let who: String
    
    init(girlJson: JSON){
        _id = girlJson["_id"].stringValue
        desc = girlJson["desc"].stringValue
        publishedAt = girlJson["publishedAt"].stringValue
        type = girlJson["type"].stringValue
        url = girlJson["url"].stringValue
        used = girlJson["used"].boolValue
        who = girlJson["who"].stringValue
    }
}

class DailyGank {
    let _id: String
    let desc: String
    let publishedAt: String
    let type: String
    let url: String
    let used: Bool
    let who: String
    
    init(dailyGankJson: JSON){
        _id = dailyGankJson["_id"].stringValue
        desc = dailyGankJson["desc"].stringValue
        publishedAt = dailyGankJson["publishedAt"].stringValue
        type = dailyGankJson["type"].stringValue
        url = dailyGankJson["url"].stringValue
        used = dailyGankJson["used"].boolValue
        who = dailyGankJson["who"].stringValue
    }
}