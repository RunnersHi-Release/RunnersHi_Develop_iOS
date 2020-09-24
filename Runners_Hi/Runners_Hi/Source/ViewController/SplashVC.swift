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
   var animationView: AnimationView?

   override func viewDidLoad() {
    super.viewDidLoad()
    setView()
    CheckInUUID(uuid: UIDevice.current.identifierForVendor?.uuidString ?? "")
    print(UIDevice.current.identifierForVendor?.uuidString)
   }
   

}
extension SplashVC {
    func setView() {
        animationView = AnimationView(name: "splash")
        animationView?.contentMode = .scaleAspectFit
           animationView?.frame = self.view.bounds
           animationView?.play()
           // Do any additional setup after loading the view.
           self.view.addSubview(animationView!)
           Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(aaaa), userInfo: nil, repeats: false)
    }
    
    @objc func aaaa() {
        guard let storyboard = UIStoryboard(name: "Tab", bundle: nil).instantiateViewController(identifier: "TabBarController") as? UITabBarController else { return }
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController = storyboard
    }
    
    func CheckInUUID(uuid: String) {
        LoginService.shared.uuidCheckIn(uuid: uuid) { networkResult in switch
        networkResult {
            case .success(let res):
                print(res)
            case .requestErr: print("requestErr")
            case .pathErr: print("path")
            case .serverErr: print("serverErr")
            case .networkFail: print("networkFail")
            }
        }
    }
    
}
