//
//  SplashVC.swift
//  Runners_Hi
//
//  Created by 김민희 on 2020/07/17.
//  Copyright © 2020 김민희. All rights reserved.
//

import UIKit
import Lottie

class SplashVC: UIViewController {
    var UuidModel : UuidData?
    var animationView: AnimationView?

   override func viewDidLoad() {
    super.viewDidLoad()
    setView()
   }
   

}
extension SplashVC {
    func setView() {
        CheckInUUID(uuid: UIDevice.current.identifierForVendor?.uuidString ?? "")
        deleteUser()
        animationView = AnimationView(name: "splash")
        animationView?.contentMode = .scaleAspectFit
           animationView?.frame = self.view.bounds
           animationView?.play()
           // Do any additional setup after loading the view.
           self.view.addSubview(animationView!)
    }
    
    @objc func aaaa() {
        guard let storyboard = UIStoryboard(name: "Tab", bundle: nil).instantiateViewController(identifier: "TabBarController") as? UITabBarController else { return }
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController = storyboard
    }
    
    func CheckInUUID(uuid: String) {
        LoginService.shared.uuidCheckIn(uuid: uuid) { networkResult in switch
        networkResult {
            case .success(let res):
                let response = res as! UuidData
                self.UuidModel = response
                self.saveUserInfo(self.UuidModel?.data?.accessToken ?? "", nickname: self.UuidModel?.data?.nickname ?? "", gender: Int64(self.UuidModel?.data?.gender ?? -1), image: Int64(self.UuidModel?.data?.image ?? -1), badge: self.UuidModel?.data?.badge ?? "", win: Int64(self.UuidModel?.data?.win ?? -1), lose: Int64(self.UuidModel?.data?.lose ?? -1))
                Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.aaaa), userInfo: nil, repeats: false)
                
            case .requestErr: print("requestErr")
            case .pathErr: print("path")
            case .serverErr: print("serverErr")
            case .networkFail: print("networkFail")
            }
        }
    }
    
    fileprivate func saveUserInfo(_ accessToken: String, nickname: String, gender: Int64, image: Int64, badge: String, win: Int64, lose: Int64) {
        CoreDataManager.shared.saveUser(accessToken: accessToken, nickname: nickname, gender: gender, image: image, badge: badge, win: win, lose: lose) { onSuccess in
            print("saved = \(onSuccess)")
        }
    }
    // CoreData 에서 값 삭제할 때 쓰는 함수
    fileprivate func deleteUser() {
        CoreDataManager.shared.deleteUser() { onSuccess in
            print("deleted = \(onSuccess)")
        }
    }
    
}
