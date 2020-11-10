//
//  MainVC.swift
//  Runners_Hi
//
//  Created by 김민희 on 2020/07/05.
//  Copyright © 2020 김민희. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    
    static let identifier: String = "MainVC"
    var blackView = UIView()
    private var battleInformation: [BattleInformation] = []
    
    @IBOutlet weak var popUpTableView: UITableView!
    @IBOutlet weak var mentLabel1: UILabel!
    @IBOutlet weak var mentLabel2: UILabel!
    @IBOutlet weak var mentLabel3: UILabel!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var runButton: UIButton!
    @IBOutlet weak var homeImg: UIImageView!
    
    @IBOutlet weak var constraint_logo_ment: NSLayoutConstraint!
    @IBOutlet weak var constraint_ment_homeImg: NSLayoutConstraint!
    @IBOutlet weak var constarint_homeImg_button: NSLayoutConstraint!
    
    @IBAction func runButtonDidTap(_ sender: Any) {
        //"RUN NOW" 버튼 클릭 시 Action
        
        blackView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        blackView.frame = self.view.frame
        self.view.addSubview(blackView)
        UIView.animate(withDuration: 0.3) {
            self.popUpTableView.transform = .identity
            self.onClickBlackView()
        }
       self.view.bringSubviewToFront(popUpTableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setbattleInformation()
       // getToken()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.popUpTableView.transform = CGAffineTransform(translationX: 0, y: self.popUpTableView.frame.height)
        self.blackView.removeFromSuperview()
    }
    fileprivate func getToken() {
        let users: [Information] = CoreDataManager.shared.getUsers()
        let usersToken: [String] = users.map({($0.accessToken ?? "")})
        print("allUsers = \(usersToken[0])")
    }

    @objc func handleDismiss() {
        popUpTableView.isHidden = true
    }

}
extension MainVC {
    
    func setView() {
        setbattleInformation()
        
        popUpTableView.transform = CGAffineTransform(translationX: 0, y: popUpTableView.frame.height)
        
        homeImg.image = UIImage(named: "imgHomeactivityMain")
        logoImg.image = UIImage(named: "homeLogo")
        self.view.backgroundColor = UIColor.backgroundgray
        secondView.backgroundColor = UIColor.white
        secondView.layer.cornerRadius = 20
        runButton.backgroundColor = UIColor.lightishBlue
        runButton.setTitle("RUN NOW", for: .normal)
        runButton.setTitleColor(.white, for: .normal)
        runButton.layer.cornerRadius = 12
        mentLabel1.font = UIFont(name: "NanumSquareB", size: 20)
        mentLabel2.font = UIFont(name: "NanumSquareB", size: 20)
        mentLabel3.font = UIFont(name: "NanumSquareB", size: 20)
        runButton.titleLabel?.font = UIFont(name: "AvenirNext-BoldItalic", size: 30)
        popUpTableView.layer.cornerRadius = 20
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        //구분선 제거
        
        popUpTableView.delegate = self
        popUpTableView.dataSource = self
        
        if self.view.frame.height > 700 {
            constraint_logo_ment.constant = 34
            constraint_ment_homeImg.constant = 59
            constarint_homeImg_button.constant = 51
            
        }
    }
    
    private func setbattleInformation() {
        let date1 = BattleInformation(ment: "다른 러너와 경쟁하기")
        let date2 = BattleInformation(ment: "나의 기록과 경쟁하기")
        
        battleInformation = [date1,date2]
    }
    func onClickBlackView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onGesture))

        blackView.addGestureRecognizer(tapGesture)
    }
    
    @objc func onGesture() {
        UIView.animate(withDuration: 0.3) {
            self.popUpTableView.transform = CGAffineTransform(translationX: 0, y: self.popUpTableView.frame.height)
            self.blackView.removeFromSuperview()
        }
    }
}

extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return battleInformation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let popUpCell = tableView.dequeueReusableCell(withIdentifier: PopUpCell.identifier, for: indexPath) as? PopUpCell else { return UITableViewCell() }
        popUpCell.setbattleInformation(ment: battleInformation[indexPath.row].ment)
        
        return popUpCell
    }
    
    
    
}
extension MainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // cell 선택 안남게하기
        
        if indexPath == [0,0] {
            //함께 달리기
            guard let PopUpPush = self.storyboard?.instantiateViewController(identifier:"MatchingGoalVC") as? MatchingGoalVC else {return}
            PopUpPush.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(PopUpPush, animated: true)
        } else {
           // 혼자달리기 넣기
        }
    }
    
}
