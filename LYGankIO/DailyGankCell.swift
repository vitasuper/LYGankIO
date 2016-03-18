//
//  DailyGankCell.swift
//  LYGankIO
//
//  Created by 韩龙粤 on 16/3/18.
//  Copyright © 2016年 vitasuper. All rights reserved.
//

import UIKit

class DailyGankCell: UITableViewCell {

    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        DailyGankCell.appearance().backgroundColor = UIColor(red:1.00, green:0.90, blue:0.78, alpha:1.0)
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
