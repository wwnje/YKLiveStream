//
//  LiveTableViewCell.swift
//  YKLiveStream
//
//  Created by wwnje on 2017/4/15.
//  Copyright © 2017年 orvnge. All rights reserved.
//

import UIKit

class LiveTableViewCell: UITableViewCell {

    @IBOutlet weak var imgBigPor: UIImageView!
    @IBOutlet weak var imgPor: UIImageView!
    @IBOutlet weak var labelNick: UILabel!
    @IBOutlet weak var labelAddr: UILabel!
    @IBOutlet weak var LabelVIewers: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
