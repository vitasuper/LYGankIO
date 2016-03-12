//
//  GankIOCell.swift
//  LYGankIO
//
//  Created by 韩龙粤 on 16/3/10.
//  Copyright © 2016年 vitasuper. All rights reserved.
//

import UIKit

class GirlCell: UITableViewCell {

    @IBOutlet weak var girlImageView: UIImageView!
    @IBOutlet weak var whoLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var watchGankLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        girlImageView.layer.masksToBounds = true
        girlImageView.layer.cornerRadius = 10
        
        GirlCell.appearance().backgroundColor = UIColor(red:1.00, green:0.90, blue:0.78, alpha:1.0)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Load girl image in the cell
    func setGirlImage(girlItem: Girl) {
        girlImageView.kf_setImageWithURL(NSURL(string: girlItem.url)!, placeholderImage: nil)
    }
    
    // Set action for tapping the girl image
    func setGirlImageAction(indexPath: NSIndexPath, target: AnyObject, action: Selector) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: target, action: action)
        girlImageView.userInteractionEnabled = true
        girlImageView.tag = indexPath.row
        girlImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // Set action for tapping the watchGankLabel
    func setWatchGankAction(target: AnyObject, action: Selector) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: target, action: action)
        watchGankLabel.userInteractionEnabled = true
        watchGankLabel.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
}
