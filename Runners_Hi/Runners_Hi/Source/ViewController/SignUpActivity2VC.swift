//
//  SignUpActivity2VC.swift
//  Runners_Hi
//
//  Created by 최영재 on 2020/12/21.
//  Copyright © 2020 김민희. All rights reserved.
//

import UIKit

class SignUpActivity2VC: UIViewController {

    @IBOutlet weak var signUp2BackBtn: UIButton!
    @IBOutlet weak var signUp2Content: UILabel!
    

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var idCheckLabel: UILabel!
    @IBOutlet weak var idCheckButton: UIButton!
    
    @IBOutlet weak var pwLabel: UILabel!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var pwCheckLabel: UILabel!
    
    @IBOutlet weak var pwReLabel: UILabel!
    @IBOutlet weak var pwReTextField: UITextField!
    @IBOutlet weak var pwReCheckLabel: UILabel!
    
    @IBOutlet weak var signUp2NextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSignUp2VC()
    }
    
    
    private func setSignUp2VC() {
        signUp2BackBtn.setBackgroundImage(UIImage(named: "btnBack" ), for: .normal)
        signUp2BackBtn.setTitle("", for: .normal)
        
        signUp2Content.text = "아이디와 비밀번호를 \n 입력해 주세요."
        signUp2Content.font = UIFont(name:"NanumSquareB", size:18.0)

        idLabel.text = "아이디"
        idLabel.font = UIFont(name:"NanumSquareR", size:14.0)
        idCheckLabel.text = ""
        
        pwLabel.text = "비밀번호"
        pwLabel.font = UIFont(name:"NanumSquareR", size:14.0)
        pwCheckLabel.text = ""
        
        pwReLabel.text = "비밀번호 확인"
        pwReLabel.font = UIFont(name:"NanumSquareR", size:14.0)
        pwReCheckLabel.text = ""
        
        
        
        
        signUp2NextBtn.layer.cornerRadius = 4
        signUp2NextBtn.setTitle("다음", for: .normal)
        signUp2NextBtn.titleLabel?.font = UIFont(name: "NanumSquareB", size:16)
        signUp2NextBtn.setTitleColor(.white, for: .normal)
        signUp2NextBtn.backgroundColor = .veryLightPink
        signUp2NextBtn.isEnabled = false
    }
}
