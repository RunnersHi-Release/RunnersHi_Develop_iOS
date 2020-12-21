//
//  SignUpActivity1VC.swift
//  Runners_Hi
//
//  Created by 최영재 on 2020/12/21.
//  Copyright © 2020 김민희. All rights reserved.
//

import UIKit

class SignUpActivity1VC: UIViewController {
    // MARK:- @IBACTION
    @IBOutlet weak var signUp1BackBtn: UIButton!
    @IBOutlet weak var signUp1Content: UILabel!
    @IBOutlet weak var allAgreeBtn: UIButton!
    @IBOutlet weak var allAgreeLabel: UILabel!
    
    @IBOutlet weak var firstAgree: UIButton!
    @IBOutlet weak var firstAgreeLabel: UILabel!
    @IBOutlet weak var firstAgreeDetail: UIButton!
    @IBOutlet weak var secondAgree: UIButton!
    @IBOutlet weak var secondAgreeLabel: UILabel!
    @IBOutlet weak var secondAgreeDetail: UIButton!
    @IBOutlet weak var thirdAgree: UIButton!
    @IBOutlet weak var thirdAgreeLabel: UILabel!
    @IBOutlet weak var thirdAgreeDetail: UIButton!
    
    @IBOutlet weak var signUp1NextBtn: UIButton!
    
    // MARK:- @IBACTION
    @IBAction func signUp1BackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)    }
    
    @IBAction func signUp1NextAction(_ sender: Any) {
        guard let signUpVC2 = self.storyboard?.instantiateViewController(identifier: "SignUpActivity2VC") else {return}
        
        self.navigationController?.pushViewController(signUpVC2, animated: true)
    }
    
    // MARK: CheckButtonAction
    var allCheck = 0
    var firstCheck = 0
    var secondCheck = 0
    var thirdCheck = 0


    @IBAction func allAgreeCheck(_ sender: Any) {
        if (allCheck == 0){
        allCheck = 1
        firstCheck = 1
        secondCheck = 1
        thirdCheck = 1
        
        allAgreeBtn.setBackgroundImage(UIImage(named: "btnCheckSelect" ), for: .normal)
        firstAgree.setBackgroundImage(UIImage(named: "btnCheckSelect" ), for: .normal)
        secondAgree.setBackgroundImage(UIImage(named: "btnCheckSelect" ), for: .normal)
        thirdAgree.setBackgroundImage(UIImage(named: "btnCheckSelect" ), for: .normal)
        }
        else {
        allCheck = 0
        firstCheck = 0
        secondCheck = 0
        thirdCheck = 0
        
        allAgreeBtn.setBackgroundImage(UIImage(named: "btnCheckUnselect" ), for: .normal)
        firstAgree.setBackgroundImage(UIImage(named: "btnCheckUnselect" ), for: .normal)
        secondAgree.setBackgroundImage(UIImage(named: "btnCheckUnselect" ), for: .normal)
        thirdAgree.setBackgroundImage(UIImage(named: "btnCheckUnselect" ), for: .normal)
        }
        nextBtnCheck()
    }
    
    @IBAction func firstAgreeCheck(_ sender: Any) {
        if (firstCheck == 1){
            firstAgree.setBackgroundImage(UIImage(named: "btnCheckUnselect" ), for: .normal)
            firstCheck = 0
        }
        else {
            firstAgree.setBackgroundImage(UIImage(named: "btnCheckSelect" ), for: .normal)
            firstCheck = 1
        }
        
        allAgreeCheck()
        nextBtnCheck()
    }
    
    @IBAction func secondAgreeCheck(_ sender: Any) {
        if (secondCheck == 1){
            secondAgree.setBackgroundImage(UIImage(named: "btnCheckUnselect" ), for: .normal)
            secondCheck = 0
        }
        else {
            secondAgree.setBackgroundImage(UIImage(named: "btnCheckSelect" ), for: .normal)
            secondCheck = 1
        }
        
        allAgreeCheck()
        nextBtnCheck()
    }
    
    
    @IBAction func thirdAgreeCheck(_ sender: Any) {
        if (thirdCheck == 1){
            thirdAgree.setBackgroundImage(UIImage(named: "btnCheckUnselect" ), for: .normal)
            thirdCheck = 0
        }
        else {
            thirdAgree.setBackgroundImage(UIImage(named: "btnCheckSelect" ), for: .normal)
            thirdCheck = 1
        }
        
        allAgreeCheck()
        nextBtnCheck()
    }
    
    // MARK:- lifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setFirstSignUpVC()
    }
    
    // MARK:- func
    private func setFirstSignUpVC() {
        signUp1BackBtn.setBackgroundImage(UIImage(named: "btnBack" ), for: .normal)
        signUp1BackBtn.setTitle("", for: .normal)
        
        signUp1Content.text = "러너스하이 이용약관에 \n 동의해주세요."
        signUp1Content.font = UIFont(name:"NanumSquareB", size:18.0)

        
        allAgreeBtn.setBackgroundImage(UIImage(named: "btnCheckUnselect" ), for: .normal)
        allAgreeBtn.setTitle("", for: .normal)
        allAgreeLabel.text = "모두 동의 (선택 정보 포함)"
        allAgreeLabel.font = UIFont(name:"NanumSquareR", size:12.0)
        
        
        firstAgree.setBackgroundImage(UIImage(named: "btnCheckUnselect" ), for: .normal)
        firstAgree.setTitle("", for: .normal)
        firstAgreeLabel.text = "[필수] 이용 약관 동의"
        firstAgreeLabel.font = UIFont(name:"NanumSquareR", size:12.0)
        firstAgreeDetail.setTitle("보기", for: .normal)
        firstAgreeDetail.setTitleColor(.lightishBlue, for: .normal)
        firstAgreeDetail.titleLabel?.font = UIFont(name: "NanumSquareR", size:12)
        
        
        secondAgree.setBackgroundImage(UIImage(named: "btnCheckUnselect" ), for: .normal)
        secondAgree.setTitle("", for: .normal)
        secondAgreeLabel.text = "[필수] 개인정보 처리방침 동의"
        secondAgreeLabel.font = UIFont(name:"NanumSquareR", size:12.0)
        secondAgreeDetail.setTitle("보기", for: .normal)
        secondAgreeDetail.setTitleColor(.lightishBlue, for: .normal)
        secondAgreeDetail.titleLabel?.font = UIFont(name: "NanumSquareR", size:12)
        
        
        thirdAgree.setBackgroundImage(UIImage(named: "btnCheckUnselect" ), for: .normal)
        thirdAgree.setTitle("", for: .normal)
        thirdAgreeLabel.text = "[선택] 광고성 정보 수신 및 마케팅 활용 동의"
        thirdAgreeLabel.font = UIFont(name:"NanumSquareR", size:12.0)
        thirdAgreeDetail.setTitle("보기", for: .normal)
        thirdAgreeDetail.setTitleColor(.lightishBlue, for: .normal)
        thirdAgreeDetail.titleLabel?.font = UIFont(name: "NanumSquareR", size:12)
        
        signUp1NextBtn.layer.cornerRadius = 4
        signUp1NextBtn.setTitle("다음", for: .normal)
        signUp1NextBtn.titleLabel?.font = UIFont(name: "NanumSquareB", size:16)
        signUp1NextBtn.setTitleColor(.white, for: .normal)
        signUp1NextBtn.backgroundColor = .veryLightPink
        signUp1NextBtn.isEnabled = false
        
    }

    private func allAgreeCheck() {
        if (firstCheck == 1 && secondCheck == 1 && thirdCheck == 1){
            allAgreeBtn.setBackgroundImage(UIImage(named: "btnCheckSelect" ), for: .normal)
        }
        else {
            allAgreeBtn.setBackgroundImage(UIImage(named: "btnCheckUnselect" ), for: .normal)
        }
    }
    
    private func nextBtnCheck() {
        if (firstCheck == 1 && secondCheck == 1) {
            signUp1NextBtn.isEnabled = true
            signUp1NextBtn.backgroundColor = .lightishBlue
        }
        else {
            signUp1NextBtn.isEnabled = false
            signUp1NextBtn.backgroundColor = .veryLightPink
        }
    }
}


