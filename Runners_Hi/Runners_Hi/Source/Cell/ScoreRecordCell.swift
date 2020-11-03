//
//  ScoreRecordCell.swift
//  Runners_Hi
//
//  Created by 최영재 on 2020/07/14.
//  Copyright © 2020 김민희. All rights reserved.
//

import UIKit

class ScoreRecordCell: UICollectionViewCell {
    static let identifier: String = "ScoreRecordCell"
    
    
    @IBOutlet weak var scoreDateLabel: UILabel!
    @IBOutlet weak var getKmLabel: UILabel!
    @IBOutlet weak var KmNameLabel: UILabel!
    @IBOutlet weak var getTimeLabel: UILabel!
    @IBOutlet weak var TimeNameLabel: UILabel!
    @IBOutlet weak var recordBackImage: UIImageView!
    
    override func awakeFromNib() {
        set()
    }
    func set(){
        print("ddd")
        print(UIScreen.main.bounds.height)
        if UIScreen.main.bounds.height < 700 {
            getKmLabel.font = UIFont(name:"AvenirNext-BoldItalic", size:24.0)
            getTimeLabel.font = UIFont(name:"AvenirNext-BoldItalic", size:24.0)
        } else {
            getKmLabel.font = UIFont(name:"AvenirNext-BoldItalic", size:28.0)
            getTimeLabel.font = UIFont(name:"AvenirNext-BoldItalic", size:28.0)
        }
    scoreDateLabel.font = UIFont(name:"NanumSquareR", size:12.0)
    scoreDateLabel.textColor = .brownishGrey
    KmNameLabel.font = UIFont(name:"NanumSquareR", size:14.0)
    TimeNameLabel.font = UIFont(name:"NanumSquareR", size:12.0)
        
    self.KmNameLabel.text = "킬로미터"
    self.TimeNameLabel.text = "러닝시간"
    }
    
}
