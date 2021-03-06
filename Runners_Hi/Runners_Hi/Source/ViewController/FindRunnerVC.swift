//
//  FindRunnerVC.swift
//  Runners_Hi
//
//  Created by 김민희 on 2020/07/10.
//  Copyright © 2020 김민희. All rights reserved.
//

import UIKit
import Lottie

class FindRunnerVC: UIViewController {
    
    var opponentModel : UuidData<OpponentInfo>?
    
    let maxTime: Float = 180.0
    var myGoTime: Int = 0
    var moveTime: Float = 0.0
    var leftTime: Int = 180
    var room: String = ""
    var animationView: AnimationView?
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var timeProgressBar: UIProgressView!
    
    @IBOutlet weak var mentTextView: UITextView!
    
    @IBOutlet weak var mentTextViewHeight: NSLayoutConstraint!
    @IBOutlet weak var mentStopButton: UIButton!
    
    @IBAction func mentStopButtonClicked(_ sender: UIButton) {
        // 중단하기 버튼 클릭 시 Event
        guard let popupVC = self.storyboard?.instantiateViewController(identifier: "MatchingStopVC") as? MatchingStopVC else {return}
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        present(popupVC, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getToken()
        basicAutoLayout()
    }
}

extension FindRunnerVC {
    private func basicAutoLayout() {
        
        // 애니메이션 추가
        animationView = AnimationView(name: "matching")
        animationView?.contentMode = .scaleAspectFit
        animationView?.frame = self.loadingView.bounds
        animationView?.play()
        animationView?.loopMode = .loop
        loadingView.addSubview(animationView!)
        
        // navigation controller 숨기기
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor.backgroundgray
        
        // Progressbar 3분으로 흐르기
        timeProgressBar.setProgress(moveTime, animated: true)
        perform(#selector(updateProgressbar), with: nil, afterDelay: 1.0)
        timeProgressBar.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        timeProgressBar.layer.cornerRadius = 3
        timeProgressBar.clipsToBounds = true
        
        // Label 디자인
        mentTextView.font = UIFont(name: "NanumSquare", size: 18)
        mentTextView.textAlignment = .center
        mentTextView.backgroundColor = UIColor.backgroundgray
        
        //textView 수정 불가하게 하기
        mentTextView.isEditable = false
        // mentTextViewHeight.constant = mentTextView.contentSize.height
        
        // 매칭 중단하기 버튼 디자인
        mentStopButton.setTitle("매칭 중단하기", for: .normal)
        mentStopButton.titleLabel?.font = UIFont(name: "NanumSquareB", size: 16)
        mentStopButton.setTitleColor(.white, for: .normal)
        mentStopButton.backgroundColor = UIColor.lightishBlue
        mentStopButton.layer.cornerRadius = 8
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(popRootVC),
                                               name: NSNotification.Name(rawValue: "StopFindRunner"),
                                               object: nil)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
    }
    
    @objc func popRootVC(){
        self.stopMatchingRequest()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // progressbar 1초씩 줄어들게 하기
    @objc func updateProgressbar() {
        moveTime = moveTime + 1.0
        timeProgressBar.progress = moveTime/maxTime
        if moveTime < maxTime {
            perform(#selector(updateProgressbar), with: nil, afterDelay: 1.0)
        }
        //        else {
        //            moveTime = 0.0
        //        }
    }
    
    
    // CoreData에서 사용자 토큰 받아오기
    fileprivate func getToken() {
        let users: [Information] = CoreDataManager.shared.getUsers()
        let usersToken: [String] = users.map({($0.accessToken ?? "")})
        findRunnerRequest(time: UserDefaults.standard.integer(forKey: "myGoalTime"), wantGender: UserDefaults.standard.integer(forKey: "myWantGender"), token: usersToken[0])
    }
    
    // 상대 러너 찾기
    func findRunnerRequest(time: Int, wantGender: Int, token: String) {
        let users: [Information] = CoreDataManager.shared.getUsers()
        let usersToken: [String] = users.map({($0.accessToken ?? "")})
        MatchingService.shared.findRunnerReq(time: time, wantGender: wantGender,jwt: usersToken[0]) {
            [weak self]
            data in
            guard let `self` = self else {return}
            switch data {
            case .success(let res):
                print("come here")
                let response = res as! DuplicateData
                if response.status == 200 {
                    if response.message == "상대 러너와 매칭 성공" {
                        // 매칭 성공
                        self.confirmMatchingRequest(jwt: usersToken[0])
                    } else if response.message == "매칭 대기 중" {
                        // 매칭 대기 중
                        if self.moveTime < self.maxTime {
                            self.findRunnerRequest(time: UserDefaults.standard.integer(forKey: "myGoalTime"), wantGender: UserDefaults.standard.integer(forKey: "myWantGender"), token: usersToken[0])
                        } else {
                            // 매칭 중단하기
                            self.stopMatchingRequest()
                            guard let notFindRunner = self.storyboard?.instantiateViewController(identifier:"NotFindRunnerVC") as? NotFindRunnerVC else {return}
                            self.navigationController?.pushViewController(notFindRunner, animated: true)
                        }
                    }
                }
                else if response.status == 400 {
                    //뭘해야하지?
                    // 이미 매칭이 된 상태?
                }
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
    func stopMatchingRequest() {
        let users: [Information] = CoreDataManager.shared.getUsers()
        let usersToken: [String] = users.map({($0.accessToken ?? "")})
        MatchingService.shared.stopMatchingReq(jwt: usersToken[0]) {
            [weak self]
            data in
            guard let `self` = self else {return}
            switch data {
            case .success(let res):
                print(".success")
                self.moveTime = 180.0
            //중단성공
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
    func confirmMatchingRequest(jwt: String) {
        let users: [Information] = CoreDataManager.shared.getUsers()
        let usersToken: [String] = users.map({($0.accessToken ?? "")})
        MatchingService.shared.confirmMatching(jwt: jwt) { networkResult in switch
            networkResult {
        case .success(let res):
            let response = res as! UuidData<OpponentInfo>
            self.opponentModel = response
            if self.opponentModel?.status == 200 {
                // 양 쪽 모두 confirm 완료
                self.saveOpponentInfo(nickname: self.opponentModel?.data?.opponentNickname ?? "", win: Int64(self.opponentModel?.data?.opponentWin ?? -1), lose: Int64(self.opponentModel?.data?.opponentLose ?? -1), image: Int64(self.opponentModel?.data?.opponentImage ?? -1), level: Int64(self.opponentModel?.data?.opponentLevel ?? -1))
                UserDefaults.standard.set(self.opponentModel?.data?.runIdx, forKey: "runIdx")
            } else if (self.opponentModel?.status == 202) || (self.opponentModel?.status == 404) {
                self.findRunnerRequest(time: UserDefaults.standard.integer(forKey: "myGoalTime"), wantGender: UserDefaults.standard.integer(forKey: "myWantGender"), token: usersToken[0])
            }
            
        case .requestErr: print("requestErr")
        case .pathErr: print("path")
        case .serverErr: print("serverErr")
        case .networkFail: print("networkFail")
        }
        }
    }
    
    // 상대방 정보 저장하는 함수
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

