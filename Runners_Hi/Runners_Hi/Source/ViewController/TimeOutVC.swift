//
//  TimeOutVC.swift
//  Runners_Hi
//
//  Created by 김민희 on 2020/11/11.
//  Copyright © 2020 김민희. All rights reserved.
//

import UIKit

class TimeOutVC: UIViewController {

    @IBOutlet weak var topLayout: NSLayoutConstraint!
    @IBOutlet weak var firtstMentLabel: UILabel!
    @IBOutlet weak var secondMentLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var goodButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        // Do any additional setup after loading the view.
    }
    

}
extension TimeOutVC {
    func setView() {
        topLayout.constant = (208.0/623.0) * self.view.frame.height
        print(topLayout.constant)
        firtstMentLabel.text = "아쉽게도 지금은\n러너를 찾을 수 없네요"
        firtstMentLabel.numberOfLines = 0
        firtstMentLabel.font = UIFont(name: "NanumSquareB", size: 20)
        
        secondMentLabel.text = "대신 나의 기록과 러닝하시겠어요?\n어제의 나를 이겨보세요"
        secondMentLabel.numberOfLines = 0
        secondMentLabel.font = UIFont(name: "NanumSquareR", size: 16)
        
        nextButton.backgroundColor = UIColor.brownishGrey
        nextButton.titleLabel?.font = UIFont(name: "NanumSquareB", size: 16)
        nextButton.setTitle("다음에 할래요", for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.layer.cornerRadius = 8
        
        goodButton.backgroundColor = UIColor.lightishBlue
        goodButton.titleLabel?.font = UIFont(name: "NanumSquareB", size: 16)
        goodButton.setTitle("좋아요", for: .normal)
        goodButton.setTitleColor(.white, for: .normal)
        goodButton.layer.cornerRadius = 8


    }
}
