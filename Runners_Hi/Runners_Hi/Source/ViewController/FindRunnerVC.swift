//
//  FindRunnerVC.swift
//  Runners_Hi
//
//  Created by 김민희 on 2020/07/10.
//  Copyright © 2020 김민희. All rights reserved.
//

import UIKit


class FindRunnerVC: UIViewController {

    var opponentModel : UuidData<OpponentInfo>?
    
    let maxTime: Float = 180.0
    var myGoTime: Int = 0
    var moveTime: Float = 0.0
    var leftTime: Int = 180
    var room: String = ""
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var timeProgressBar: UIProgressView!

    @IBOutlet weak var mentTextView: UITextView!
    
    @IBOutlet weak var mentTextViewHeight: NSLayoutConstraint!
    @IBOutlet weak var mentStopButton: UIButton!
    
    @IBAction func mentStopButtonClicked(_ sender: UIButton) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getToken()
        basicAutoLayout()
    }
}

extension FindRunnerVC {
    private func basicAutoLayout() {
        // mentStopButton.
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor.backgroundgray
        logoImage.image = UIImage(named: "matchLogo")
        timeProgressBar.setProgress(moveTime, animated: true)
        perform(#selector(updateProgressbar), with: nil, afterDelay: 1.0)
        timeProgressBar.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        timeProgressBar.layer.cornerRadius = 3
        timeProgressBar.clipsToBounds = true
        mentTextView.font = UIFont(name: "NanumSquare", size: 18)
        mentTextView.textAlignment = .center
        mentTextView.backgroundColor = UIColor.backgroundgray
        //textView 수정 불가하게 하기
        mentTextView.isEditable = false
        // mentTextViewHeight.constant = mentTextView.contentSize.height
        mentStopButton.setTitle("매칭 중단하기", for: .normal)
        mentStopButton.titleLabel?.font = UIFont(name: "NanumSquareB", size: 16)
        mentStopButton.setTitleColor(.white, for: .normal)
        mentStopButton.backgroundColor = UIColor.lightishBlue
        mentStopButton.layer.cornerRadius = 8
    }
    
    @objc func updateProgressbar() {
        moveTime = moveTime + 1.0
        timeProgressBar.progress = moveTime/maxTime
        if moveTime < maxTime {
            perform(#selector(updateProgressbar), with: nil, afterDelay: 1.0)
        } else {
            moveTime = 0.0
        }
    }
    func matchingRequest(time: Int, wantGender: Int, token: String) {
        MatchingService.shared.matchingRequest(time: time, wantGender: wantGender, jwt: token) { networkResult in switch
        networkResult {
        case .success(let runIdx):
            UserDefaults.standard.set(runIdx, forKey: "matchingIdx")
            self.getOpponentInfo()
//            guard let LetsRun = self.storyboard?.instantiateViewController(identifier:"OpponentProfileVC") as? OpponentProfileVC else {return}
//            self.navigationController?.pushViewController(LetsRun, animated: true)
        case .requestErr: print("requestErr")
        case .pathErr: print("path")
        case .serverErr: print("serverErr")
        case .networkFail: print("networkFail")
            }
        }
    }
    fileprivate func getToken() {
        let users: [Information] = CoreDataManager.shared.getUsers()
        let usersToken: [String] = users.map({($0.accessToken ?? "")})
        matchingRequest(time: UserDefaults.standard.integer(forKey: "myGoalTime"), wantGender: UserDefaults.standard.integer(forKey: "myWantGender"), token: usersToken[0])
    }
    func getOpponentInfo() {
        let users: [Information] = CoreDataManager.shared.getUsers()
        let usersToken: [String] = users.map({($0.accessToken ?? "")})
        ProfileService.shared.opponentProfileLoading(jwt: usersToken[0], runIdx: UserDefaults.standard.string(forKey: "matchingIdx") ?? "") {
            [weak self]
            data in
            guard let `self` = self else {return}
            switch data {
            case .success(let res):
                let response = res as! UuidData<OpponentInfo>
                self.opponentModel = response
                self.saveOpponentInfo(nickname: self.opponentModel?.data?.nickname ?? "", win: Int64(self.opponentModel?.data?.win ?? -1), lose: Int64(self.opponentModel?.data?.lose ?? -1), image: Int64(self.opponentModel?.data?.image ?? -1), level: Int64(self.opponentModel?.data?.level ?? -1))
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
    fileprivate func saveOpponentInfo(nickname: String, win: Int64, lose: Int64, image: Int64, level: Int64) {
        CoreDataManager.shared.saveOpponent(level: level, lose: lose, nickname: nickname, profileImage: image, win: win) { onSuccess in
            print("saved = \(onSuccess)")
            if onSuccess == true {
                guard let LetsRun = self.storyboard?.instantiateViewController(identifier:"OpponentProfileVC") as? OpponentProfileVC else {return}
                self.navigationController?.pushViewController(LetsRun, animated: true)
            }
        }
    }
}
extension String {
    func fromBase64URL() -> String? {
        var base64 = self
        base64 = base64.replacingOccurrences(of: "-", with: "+")
        base64 = base64.replacingOccurrences(of: "_", with: "/")
        while base64.count % 4 != 0 {
            base64 = base64.appending("=")
        }
        guard let data = Data(base64Encoded: base64) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64URL() -> String {
        var result = Data(self.utf8).base64EncodedString()
        result = result.replacingOccurrences(of: "+", with: "-")
        result = result.replacingOccurrences(of: "/", with: "_")
        result = result.replacingOccurrences(of: "=", with: "")
        return result
    }
}

