//
//  MatchingStopVC.swift
//  Runners_Hi
//
//  Created by 김민희 on 2020/10/01.
//  Copyright © 2020 김민희. All rights reserved.
//

import UIKit

class MatchingStopVC: UIViewController {

    @IBOutlet weak var popUpView: UIView!
    
    @IBOutlet weak var mentLabel1: UILabel!
    @IBOutlet weak var mentLabel2: UILabel!
    
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var keepButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        // Do any additional setup after loading the view.
    }

}
extension MatchingStopVC {
    func setView() {

        let taps = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.view.addGestureRecognizer(taps)
        
        stopButton.backgroundColor = UIColor.brownishGrey
        stopButton.titleLabel?.font = UIFont(name: "NanumSquareB", size: 16)
        stopButton.setTitle("그만할래요", for: .normal)
        stopButton.layer.cornerRadius = 8
        stopButton.setTitleColor(.white, for: .normal)
        
        keepButton.backgroundColor = UIColor.lightishBlue
        keepButton.titleLabel?.font = UIFont(name: "NanumSquareB", size: 16)
        keepButton.setTitle("계속할래요", for: .normal)
        keepButton.layer.cornerRadius = 8
        keepButton.setTitleColor(.white, for: .normal)
        
        mentLabel1.font = UIFont(name: "NanumSquareB", size: 20)
        mentLabel2.font = UIFont(name: "NanumSquareB", size: 20)
        
        popUpView.layer.cornerRadius = 8
    }

    @objc func handleTapGesture(recognizer: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
        }
}
