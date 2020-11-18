//
//  NotFindRunnerVC.swift
//  Runners_Hi
//
//  Created by 김민희 on 2020/10/21.
//  Copyright © 2020 김민희. All rights reserved.
//

import UIKit

class NotFindRunnerVC: UIViewController {

    
    @IBOutlet weak var firstMentLabel: UILabel!
    @IBOutlet weak var secondMentLabel: UILabel!
    @IBOutlet weak var matchImage: UIImageView!
    @IBOutlet weak var thirdMentLabel: UILabel!
    @IBOutlet weak var fourthMentLabel: UILabel!
    @IBOutlet weak var nextTimeButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false

        // Do any additional setup after loading the view.
    }
    
}

extension NotFindRunnerVC {
    func setView() {
        
        firstMentLabel.text = "아쉽게도 지금은"
        firstMentLabel.font = UIFont(name: "NanumSquareB", size: 20)
        
        secondMentLabel.text = "러너를 찾을 수 없네요"
        secondMentLabel.font = UIFont(name: "NanumSquareB", size: 20)
        
        matchImage.image = UIImage(named: "imgMatchfailactivityGrayhands")
        
        thirdMentLabel.text = "대신 나의 기록과 러닝하시겠어요?"
        thirdMentLabel.font = UIFont(name: "NanumSquareR", size: 16)
        
        fourthMentLabel.text = "어제의 나를 이겨보세요"
        fourthMentLabel.font = UIFont(name: "NanumSquareR", size: 16)
        
        nextTimeButton.setTitle("다음에 할래요.", for: .normal)
        nextTimeButton.titleLabel?.font = UIFont(name: "NanumSquareB", size: 16)
        nextTimeButton.tintColor = .white
        nextTimeButton.backgroundColor = UIColor.brownishGrey
        nextTimeButton.layer.cornerRadius = 8
        
        yesButton.setTitle("좋아요", for: .normal)
        yesButton.titleLabel?.font = UIFont(name: "NanumSquareB", size: 16)
        yesButton.tintColor = .white
        yesButton.backgroundColor = UIColor.lightishBlue
        yesButton.layer.cornerRadius = 8
    }
}
