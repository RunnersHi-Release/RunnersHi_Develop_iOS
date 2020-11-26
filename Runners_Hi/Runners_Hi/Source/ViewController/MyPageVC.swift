//
//  MyPageVC.swift
//  Runners_Hi
//
//  Created by 김민희 on 2020/07/06.
//  Copyright © 2020 김민희. All rights reserved.
//

import UIKit

class MyPageVC: UIViewController {
    static let identifier: String = "MyPageVC"
    var MyProfileModel: MyProfile?
    
    // 배지 디테일 페이지로 넘겨줄 플래그 값
    var indexflag: Int? = 999999
    var myHeight: CGFloat = 0.0
    var myHeight2: CGFloat = 0.0
    
    @IBOutlet weak var myPageCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundgray
        self.myPageCollectionView.backgroundColor = .backgroundgray
        self.myPageCollectionView.dataSource = self
        self.myPageCollectionView.delegate = self
       // getProfileBadge()
    }
    
}


extension MyPageVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return MyProfileModel?.result.badge.count ?? 0
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        guard let ProfileBadgeCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileBadgeCell.identifier, for: indexPath) as? ProfileBadgeCell else { return UICollectionViewCell()}
        let myProfileBeforeBadgeImage = ["imgBadgeEggEmpty","imgBadgeChickEmpty","imgBadgeChickenEmpty","imgBadgeBatEmpty","imgBadgeBirdEmpty", "imgBadgeTurtleEmpty","imgBadge50Empty","imgBadge100Empty","imgBadge150Empty","imgBadgeStraightEmpty","imgBadgeSpeedEmpty","imgBadgeFlameEmpty"]
        
        let myProfileBadgeImage = ["imgBadgeEgg","imgBadgeChick","imgBadgeChicken","imgBadgeBat","imgBadgeBird", "imgBadgeTurtle","imgBadge50","imgBadge100","imgBadge150","imgBadgeStraight","imgBadgeSpeed","imgBadgeFlame"]
        
        let myProfileBadgeLabel = ["첫승달성","10승 달성", "50승 달성", "최고 페이스", "최장 거리", "최저 페이스", "50시간 달성", "100시간 달성", "150시간 달성", "10일 연속 러닝", "연속 5승", "연속 10승"]
        
        // 배지 이미지 삽입
//        let profileBadgeList = MyProfileModel?.result.badge
        let users: [Information] = CoreDataManager.shared.getUsers()
        let profileBadgeList = (users.map({($0.badge)})[0])
        
        if profileBadgeList?[indexPath.row] == false {
            ProfileBadgeCell.myProfileBadge.image = UIImage(named: myProfileBeforeBadgeImage[indexPath.row])
            
            // false일 때는 item select 안되도록 설정
            ProfileBadgeCell.isUserInteractionEnabled = false
        }
        else {
            ProfileBadgeCell.myProfileBadge.image = UIImage(named: myProfileBadgeImage[indexPath.row])
            ProfileBadgeCell.isUserInteractionEnabled = true

        }
        
        
        ProfileBadgeCell.myProfileName.text = myProfileBadgeLabel[indexPath.row]
        
        
        return ProfileBadgeCell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let users: [Information] = CoreDataManager.shared.getUsers()
            let level = (users.map({Int(($0.level ?? 0))})[0])
            let win = (users.map({Int(($0.win ?? 0))})[0])
            let lose = (users.map({Int(($0.lose ?? 0))})[0])
            let name:String = (users.map({($0.nickname ?? "")})[0])
            
            let  myprofileImageList = ["iconRedmanShorthair","iconBluemanShorthair","iconRedmanBasichair","iconBluemanPermhair","iconRedwomenPonytail", "iconBluewomenPonytail","iconRedwomenShortmhair","iconBluewomenPermhair","iconRedwomenBunhair"]
            
            let levelList = ["초급","중급","고급"]
            guard let MyProfileHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MyProfileHeader.identifier, for: indexPath) as? MyProfileHeader else { return UICollectionViewCell()}
            
            let myprofileImageFlag:Int = (users.map({Int(($0.image ?? 0))})[0])
            
            myHeight = MyProfileHeader.myProfileImage.frame.height
            myHeight2 = MyProfileHeader.myProfileBack.frame.height
//
            MyProfileHeader.myProfileImage.image = UIImage(named: myprofileImageList[myprofileImageFlag - 1])
            MyProfileHeader.myProfileBack.image = UIImage(named: "whiteboxRecdetailactivityMyrecord")
            MyProfileHeader.LvLabel?.text = "\(levelList[level-1])"
            MyProfileHeader.ScoreLabel?.text = "\(win)" + "승 " + "\(lose)" + "패"
            MyProfileHeader.myProfileName?.text = name
//
            
            return MyProfileHeader
        default: assert(false, "응 아니야") }
        
        
    }
    
    
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        let width: CGFloat = collectionView.frame.width
////        let height: CGFloat = ( 386.0 / 750.0 ) * self.view.frame.height
//        let height : CGFloat = 366
////        print(self.view.frame.height, height)
//        //CGFloat = 135.0 + 56.0 - 48.0 + 234.0
//        //let height: CGFloat = 135.0 + 56.0 - 48.0 + 234.0
//        return CGSize(width: width, height: height) }
//
}

extension MyPageVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let receiveBadgeDetailVC = self.storyboard?.instantiateViewController(identifier: "BadgeDetailVC") as? BadgeDetailVC else {return}
        
        // indexflag 값 detail 페이지로 넘겨주기
        receiveBadgeDetailVC.receivedIndexPath = indexPath.row
        
        
        receiveBadgeDetailVC.modalPresentationStyle = .fullScreen
        present(receiveBadgeDetailVC, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt IndexPath: IndexPath) -> CGSize{
        return CGSize(width: 80, height: 137)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 37, bottom: 24, right: 38)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 30
    }
}

extension MyPageVC {
    func getProfileBadge(){
        ProfileService.shared.profilebadgeloading() {
            [weak self]
            data in
            guard let `self` = self else {return}
            switch data {
                
            case .success(let res):
                let response = res as! MyProfile
                self.MyProfileModel = response
                self.myPageCollectionView.reloadData()
                self.myPageCollectionView.dataSource = self
                self.myPageCollectionView.delegate = self
                
                
            case .requestErr:
                print(".requestErr")
            case .pathErr:
                print(".pathErr")
            case .serverErr:
                print(".serverErr")
            case .networkFail:
                print(".networkFail")
            }
            
        }
    }
}
