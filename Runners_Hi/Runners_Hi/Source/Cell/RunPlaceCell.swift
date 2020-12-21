//
//  RunPlaceCell.swift
//  Runners_Hi
//
//  Created by 김민희 on 2020/11/28.
//  Copyright © 2020 김민희. All rights reserved.
//

import UIKit

class RunPlaceCell: UICollectionViewCell {
    static let identifier = "RunPlaceCell"
    var levelStruct = ["초급","중급","고급"]
    var profileImageStruct = ["iconRedmanShorthair","iconBluemanShorthair","iconRedmanBasichair","iconBluemanPermhair","iconRedwomenPonytail","iconBluewomenPonytail","iconRedwomenShortmhair","iconBluewomenPermhair","iconRedwomenBunhair"]
    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var levelTextLabel: UILabel!
    @IBOutlet weak var totalTextLabel: UILabel!
    
    override func awakeFromNib() {
        setFont()
    }
    
    func setCell(runPlace: RunPlace) {
//        if runPlace.rank == 1 {
//            placeImage.image = UIImage(named: "iconRunWin")
//        } else if runPlace.rank == 2 {
//            placeImage.image = UIImage(named: "iconRunLose")
//        }
        profileImage.image = UIImage(named: profileImageStruct[runPlace.profile - 1])
        nickLabel.text = runPlace.nick
        levelLabel.text = levelStruct[runPlace.level - 1]
        totalLabel.text = "\(runPlace.win)승 \(runPlace.lose)패"
    }
    func setFont() {
        self.layer.cornerRadius = 10
        self.layer.shadowOffset = CGSize(width: 1.0,height: 2.0)
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 0.2
        
        layer.masksToBounds = false
        
        self.backgroundColor = UIColor.backgroundgray
        nickLabel.font = UIFont(name:"NanumSquareB", size:12.0)
        levelLabel.font = UIFont(name:"NanumSquareB", size:14.0)
        totalLabel.font = UIFont(name:"NanumSquareB", size:14.0)
        levelTextLabel.font = UIFont(name:"NanumSquareR", size:12.0)
        totalTextLabel.font = UIFont(name:"NanumSquareR", size:12.0)
    }
    
    
}
