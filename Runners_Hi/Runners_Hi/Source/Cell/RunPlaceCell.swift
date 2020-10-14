//
//  RunPlaceCell.swift
//  Runners_Hi
//
//  Created by 김민희 on 2020/10/06.
//  Copyright © 2020 김민희. All rights reserved.
//

import UIKit

class RunPlaceCell: UITableViewCell {
    static let identifier: String = "RunPlaceCell"
    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
