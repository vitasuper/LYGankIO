//
//  GankIOHttpClient.swift
//  LYGankIO
//
//  Created by 韩龙粤 on 16/3/10.
//  Copyright © 2016年 vitasuper. All rights reserved.
//

import SwiftyJSON
import Alamofire

protocol GirlImagesDataDelegate {
    func girlImagesDataDidReceive(girlJson: JSON)
}

protocol DailyGankDataDelegate {
    func DailyGankDataDidReceive(dailyGankJson: JSON)
}


class GankIOHttpClient {
    // singleton pattern
    static let sharedInstance = GankIOHttpClient()
    
    // Delegate part
    var girlImagesDataDelegate: GirlImagesDataDelegate?
    var dailyGankDataDelegate: DailyGankDataDelegate?
    
    
    private init() {}
    
    func catchGirlImagesData(pageNo: Int) {
        let imageUrl = ("http://gank.io/api/data/福利/10/\(pageNo)").stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        Alamofire.request(.GET, imageUrl).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let girlJson = JSON(value)
                    self.girlImagesDataDelegate?.girlImagesDataDidReceive(girlJson)  // call the function of the delegate
                }
            case .Failure(let error):
                print(error)
            }
        }
        
    }
    
    func catchDailyGankData(date: String) {
        let gankUrl = ("http://gank.io/api/day/" + date).stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        // print(gankUrl)
        
        Alamofire.request(.GET, gankUrl).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let dailyGankJson = JSON(value)
                    self.dailyGankDataDelegate?.DailyGankDataDidReceive(dailyGankJson)
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    
    
}
