//
//  BadgeDetailVC.swift
//  Runners_Hi
//
//  Created by 최영재 on 2020/07/18.
//  Copyright © 2020 김민희. All rights reserved.
//

import UIKit

class BadgeDetailVC: UIViewController {
    
    var BadgeDetailModel: BadgeDetailData?
    var receivedIndexPath: Int?
    
    @IBOutlet weak var badgeDetailTitle: UILabel!
    @IBOutlet weak var badgeDetailImage: UIImageView!
    @IBOutlet weak var badgeDetailContent: UILabel!
    @IBOutlet weak var badgeDetailLittleContent: UILabel!
    @IBOutlet weak var badgeDetailOption: UILabel!
    
    @IBOutlet weak var badgeDetailBackButton: UIButton!
    @IBAction func badgeDetailBackButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setIndexPath()
        setDetailData()
//        getBadgeDetail()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
         let myProfileBadgeImage = ["imgBadgeEgg","imgBadgeChick","imgBadgeChicken","imgBadgeBat","imgBadgeBird", "imgBadgeTurtle","imgBadge50","imgBadge100","imgBadge150","imgBadgeStraight","imgBadgeSpeed","imgBadgeFlame"]
       
        let myProfileBadgeTitle = ["1", "2", "3", "4", "5", "6", "7", "8","9", "10", "11","12"]
        let myProfileContent = ["1", "2", "3", "4", "5", "6", "7", "8","9", "10", "11","12"]
        let myProfileLittleContent = ["1", "2", "3", "4", "5", "6", "7", "8","9", "10", "11","12"]
        let myProfileOption = ["1", "2", "3", "4", "5", "6", "7", "8","9", "10", "11","12"]
        
        //  서버에서 받아오는 경우 데이터 처리
//        badgeDetailTitle.text = self.BadgeDetailModel?.result.title ?? ""
//        badgeDetailImage.image = UIImage(named: myProfileBadgeImage[receivedIndexPath ?? 123123])
//        badgeDetailContent.text = self.BadgeDetailModel?.result.content ?? ""
//        badgeDetailLittleContent.text = self.BadgeDetailModel?.result.littleContent ?? ""
//        badgeDetailOption.text = self.BadgeDetailModel?.result.option ?? ""
        
        badgeDetailTitle.text = myProfileBadgeTitle[receivedIndexPath ?? 123123]
        badgeDetailImage.image = UIImage(named: myProfileBadgeImage[receivedIndexPath ?? 123123])
        badgeDetailContent.text = myProfileContent[receivedIndexPath ?? 123123]
        badgeDetailLittleContent.text = myProfileLittleContent[receivedIndexPath ?? 123123]
        badgeDetailOption.text = myProfileOption[receivedIndexPath ?? 123123]
    }
    
    
    
    private func setIndexPath() {
        // mypage 탭에서 받아온 IndexPath
        guard let receivedIndexPath = self.receivedIndexPath else {return}
    }
    
    private func setDetailData() {
         
         badgeDetailBackButton.setImage(UIImage(named: "btnBack"), for: .normal)
       
        
        badgeDetailTitle.font = UIFont(name:"NanumSquareB", size:20.0)
        badgeDetailContent.font = UIFont(name:"NanumSquareB", size:18.0)
        badgeDetailLittleContent.font = UIFont(name:"NanumSquareR", size:16.0)
        badgeDetailOption.font = UIFont(name:"NanumSquareB", size:20.0)
        
        badgeDetailContent.numberOfLines = 0
        badgeDetailLittleContent.numberOfLines = 0
        
        badgeDetailContent.setLinespace(spacing: 9)
        badgeDetailLittleContent.setLinespace(spacing: 8)
        
        badgeDetailTitle.textAlignment = .center;
        badgeDetailContent.textAlignment = .center;
        badgeDetailLittleContent.textAlignment = .center;
        badgeDetailOption.textAlignment = .center;
        
        
    }
    
    
}

//extension BadgeDetailVC {
//    func getBadgeDetail(){
//        BadgeDetailService.shared.badgeDetailloading(flag: self.receivedIndexPath ?? 1) {
//            [weak self]
//            data in
//            guard let `self` = self else {return}
//            switch data {
//
//
//            case .success(let res):
//                let response = res as! BadgeDetailData
//                self.BadgeDetailModel = response
//                self.viewWillAppear(true)
//
//
//            case .requestErr:
//                print(".requestErr")
//            case .pathErr:
//                print(".pathErr")
//            case .serverErr:
//                print(".serverErr")
//            case .networkFail:
//                print(".networkFail")
//            }
//
//        }
//    }
//}

extension UILabel {
    func setLinespace(spacing: CGFloat) {
        if let text = self.text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            
            style.lineSpacing = spacing
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, attributeString.length))
            
            self.attributedText = attributeString
        }
    }
}
