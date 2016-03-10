//
//  GankIOCell.swift
//  LYGankIO
//
//  Created by 韩龙粤 on 16/3/10.
//  Copyright © 2016年 vitasuper. All rights reserved.
//

import UIKit

class GankIOCell: UITableViewCell {

    @IBOutlet weak var girlImageView: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setGirlImage(girlItem: Girl) {
        print(girlItem.url)
        girlImageView.kf_setImageWithURL(NSURL(string: girlItem.url)!, placeholderImage: nil)
    }

}
