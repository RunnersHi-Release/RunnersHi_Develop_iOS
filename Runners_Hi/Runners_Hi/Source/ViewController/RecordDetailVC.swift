//
//  RecordDetailVC.swift
//  Runners_Hi
//
//  Created by 최영재 on 2020/09/28.
//  Copyright © 2020 김민희. All rights reserved.
//

import UIKit

class RecordDetailVC: UIViewController {
    @IBOutlet weak var recordDetailBackButton: UIButton!
    @IBOutlet weak var recordDateLabel: UILabel!
    @IBOutlet weak var recordTimeLabel: UILabel!
    @IBOutlet weak var recordNaverView: UIView!
    
    @IBOutlet weak var myRecordDetailBackground: UIImageView!
    @IBOutlet weak var myRecordKm: UILabel!
    @IBOutlet weak var myRecordKmName: UILabel!
    @IBOutlet weak var myRecordPace: UILabel!
    @IBOutlet weak var myRecordPaceName: UILabel!
    @IBOutlet weak var myRecordTime: UILabel!
    @IBOutlet weak var myRecordTimeName: UILabel!
    
    @IBOutlet weak var rivalRecordDetailBackground: UIImageView!
    @IBOutlet weak var rivalRecordName: UILabel!
    @IBOutlet weak var rivalRecordKm: UILabel!
    @IBOutlet weak var rivalRecordKmName: UILabel!
    @IBOutlet weak var rivalRecordPace: UILabel!
    @IBOutlet weak var rivalRecordPaceName: UILabel!
    @IBOutlet weak var rivalRecordTime: UILabel!
    @IBOutlet weak var rivalRecordTimeName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
}

extension RecordDetailVC{
    private func recordDetailVCSetting() {
        recordDetailBackButton.setImage(UIImage(named: "btnBack"), for: .normal)
        
        
        recordDateLabel.font = UIFont(name:"NanumSquareB", size:20.0)
        recordTimeLabel.font = UIFont(name:"NanumSquareR", size:14.0)
    }
    
}
