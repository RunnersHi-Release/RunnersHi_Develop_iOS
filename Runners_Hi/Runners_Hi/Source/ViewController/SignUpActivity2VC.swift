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
    
    @IBAction func signUp2BackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSignUp2VC()
        loginCheck()
    }
    
}
extension SignUpActivity2VC {
    
    private func setSignUp2VC() {
        signUp2BackBtn.setBackgroundImage(UIImage(named: "btnBack" ), for: .normal)
        signUp2BackBtn.setTitle("", for: .normal)
        
        signUp2Content.text = "아이디와 비밀번호를 \n 입력해 주세요."
        signUp2Content.font = UIFont(name:"NanumSquareB", size:18.0)

        idLabel.text = "아이디"
        idLabel.font = UIFont(name:"NanumSquareR", size:14.0)
        idTextField.layer.cornerRadius = 4.0
        idTextField.layer.borderWidth = 1.0
        idTextField.layer.borderColor = UIColor.veryLightPink.cgColor
        idTextField.layer.masksToBounds = true
        idTextField.font = UIFont(name:"NanumSquareR", size:12.0)
        idTextField.addLeftPadding()
        idTextField.placeholder = "4-15자 영/숫자를 사용하세요."
        idCheckLabel.text = "하하"
        idCheckLabel.alpha = 0
        idCheckLabel.font = UIFont(name: "NanumSquareR", size: 12.0)


        
        idCheckButton.layer.cornerRadius = 4.0
        idCheckButton.setTitle("중복확인", for: .normal)
        idCheckButton.titleLabel?.font = UIFont(name: "NanumSquareB", size:12)
        idCheckButton.setTitleColor(.white, for: .normal)
        idCheckButton.backgroundColor = .lightishBlue
        idCheckButton.isEnabled = false
        
        
        pwLabel.text = "비밀번호"
        pwLabel.font = UIFont(name:"NanumSquareR", size:14.0)
        pwTextField.layer.cornerRadius = 4.0
        pwTextField.layer.borderWidth = 1.0
        pwTextField.layer.borderColor = UIColor.veryLightPink.cgColor
        pwTextField.layer.masksToBounds = true
        pwTextField.font = UIFont(name:"NanumSquareR", size:12.0)
        pwTextField.addLeftPadding()
        pwTextField.placeholder = "8-16자 영문/대/소문자/숫자/특수문자를 사용하세요."
        pwCheckLabel.text = "하하"
        pwCheckLabel.alpha = 0
        pwCheckLabel.font = UIFont(name: "NanumSquareR", size: 12.0)

        
        
        pwReLabel.text = "비밀번호 확인"
        pwReLabel.font = UIFont(name:"NanumSquareR", size:14.0)
        pwReTextField.layer.cornerRadius = 4.0
        pwReTextField.layer.borderWidth = 1.0
        pwReTextField.layer.borderColor = UIColor.veryLightPink.cgColor
        pwReTextField.layer.masksToBounds = true
        pwReTextField.font = UIFont(name:"NanumSquareR", size:12.0)
        pwReTextField.addLeftPadding()
        pwReTextField.placeholder = "비밀번호를 다시 확인해 주세요."
        pwReCheckLabel.text = "하하"
        pwReCheckLabel.alpha = 0
        pwReCheckLabel.font = UIFont(name: "NanumSquareR", size: 12.0)


        
        signUp2NextBtn.layer.cornerRadius = 4
        signUp2NextBtn.setTitle("다음", for: .normal)
        signUp2NextBtn.titleLabel?.font = UIFont(name: "NanumSquareB", size:16)
        signUp2NextBtn.setTitleColor(.white, for: .normal)
        signUp2NextBtn.backgroundColor = .veryLightPink
        signUp2NextBtn.isEnabled = false
    }

    
    private func loginCheck() {
        idTextField.addTarget(self, action: #selector(idTextChecked(_:)), for: .editingChanged)
        pwTextField.addTarget(self, action: #selector(pwTextChecked(_:)), for: .editingChanged)
        pwReTextField.addTarget(self, action: #selector(pwReTextChecked(_:)), for: .editingChanged)
    }
    
    
    func isValidId(id: String?) -> Bool {
        guard id != nil else { return false }
        //받아오는 id값이 비어있으면 안되겠쥬?
        let regEx = "[A-Za-z0-9]{4,15}"
        // 4~15자 영어,숫자 제한 정규표현식
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        //NSPredicate는 검색 조건을 텍스트로 입력하여 검색할 수 있게하는거라구 한다..SQL문이라
        // 너무 자세하게하면 어렵다구한다..
        // %@는 하나의 객체로 치환해주는 역할을 함.
        return pred.evaluate(with: id)
        // id 값이 pred의 값과 일치하는지 않하는지 여부를 판단해줌
        // 결과값이 true false로 나옴
    }
    
    func isValidNick(nick: String?) -> Bool {
        guard nick != nil else { return false }
        let regEx = "[ㄱ-ㅎㅏ-ㅣ가-힣A-Za-z0-9]{2,6}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: nick)
    }
    
    func isValidPw(pw: String?) -> Bool {
        guard pw != nil else { return false }
        let regEx = "[A-Za-z0-9!_@$%^&+=]{8,16}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: pw)
        //_-^
    }
    
    
    @objc private func idTextChecked(_ TextLabel: UILabel) {
        
        if ( isValidId(id: idTextField.text)) {
            idCheckLabel.text = "중복확인이 필요합니다."
            idCheckLabel.alpha = 1
            idCheckLabel.font = UIFont(name: "NanumSquareR", size: 12.0)
            idCheckLabel.textColor = UIColor.grapefruit
            idTextField.layer.borderColor = UIColor.grapefruit.cgColor
            idTextField.layer.borderWidth = 1
            idTextField.layer.masksToBounds = true
            idTextField.layer.cornerRadius = 8.0
            self.idCheckButton.isEnabled = true
        }
        else
        {
            idCheckLabel.text = "4-15자 영/숫자를 사용하세요."
            idCheckLabel.alpha = 1
            idCheckLabel.font = UIFont(name: "NanumSquareR", size: 12.0)
            idCheckLabel.textColor = UIColor.grapefruit
            idTextField.layer.borderColor = UIColor.grapefruit.cgColor
            idTextField.layer.borderWidth = 1
            idTextField.layer.masksToBounds = true
            idTextField.layer.cornerRadius = 8.0
            self.idCheckButton.isEnabled = false

        }
    }
    
    @objc private func pwTextChecked(_ TextLabel: UILabel) {
        if ( isValidPw(pw: pwTextField.text)){
            pwCheckLabel.text = "사용가능한 비밀번호입니다."
            pwCheckLabel.alpha = 1
            pwCheckLabel.font = UIFont(name: "NanumSquareR", size: 12.0)
            pwCheckLabel.textColor = UIColor.lightishBlue
            
            pwTextField.layer.borderColor = UIColor.veryLightPink.cgColor
            pwTextField.layer.borderWidth = 1
            pwTextField.layer.masksToBounds = true
            pwTextField.layer.cornerRadius = 8.0
            
            pwReTextField.isEnabled = true
            pwReTextField.backgroundColor = .white
            
        }
        else
        {
            pwCheckLabel.text = "8-16자 영문 대/소문자,숫자,특수문자를 사용하세요."
            pwCheckLabel.alpha = 1
            pwCheckLabel.font = UIFont(name: "NanumSquareR", size: 12.0)
            pwCheckLabel.textColor = UIColor.grapefruit
            pwTextField.layer.borderColor = UIColor.grapefruit.cgColor
            pwTextField.layer.borderWidth = 1
            pwTextField.layer.masksToBounds = true
            pwTextField.layer.cornerRadius = 8.0
            pwReTextField.isEnabled = false
            
        }
    }
    
    @objc private func pwReTextChecked(_ TextLabel: UILabel) {
        if(pwTextField.text == pwReTextField.text) {
            pwReCheckLabel.text = "비밀번호가 일치합니다"
            pwReCheckLabel.alpha = 1
            pwReCheckLabel.font = UIFont(name: "NanumSquareR", size: 12.0)
            pwReCheckLabel.textColor = UIColor.lightishBlue
            
            pwReTextField.layer.borderColor = UIColor.veryLightPink.cgColor
            pwReTextField.layer.borderWidth = 1
            pwReTextField.layer.masksToBounds = true
            pwReTextField.layer.cornerRadius = 8.0
        }
        else{
            pwReCheckLabel.text = "설정하신 비밀번호와 다릅니다"
            pwReCheckLabel.alpha = 1
            pwReCheckLabel.font = UIFont(name: "NanumSquareR", size: 12.0)
            pwReCheckLabel.textColor = UIColor.grapefruit
            pwReTextField.layer.borderColor = UIColor.grapefruit.cgColor
            pwReTextField.layer.borderWidth = 1
            pwReTextField.layer.masksToBounds = true
            pwReTextField.layer.cornerRadius = 8.0
        }
    }
}
