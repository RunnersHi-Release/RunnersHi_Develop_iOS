///
//  RunActivityVC.swift
//  Runners_Hi
//
//  Created by 김민희 on 2020/07/11.
//  Copyright © 2020 김민희. All rights reserved.
//

import UIKit

import CoreMotion
import NMapsMap
import CoreLocation

class RunActivityVC: UIViewController, CLLocationManagerDelegate {
    private var runPlace: [RunPlace] = []
    var rank : UuidData<RunningRankingData>?
    var myRank : Int = 1
    
    let stopColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
    let startColor = UIColor(red: 0.0, green: 0.75, blue: 0.0, alpha: 1.0)
    // values for the pedometer data
    var numberOfSteps:Int! = nil
    var finalKm:Int = 0
    var distance:Double! = nil
    var averagePace:Double! = nil
    var pace:Double! = nil
    var kmDistance:Double! = nil
    
    var locationManager:CLLocationManager!
    
    @IBOutlet weak var scrolleView: UIScrollView!
    
    var pedometer = CMPedometer()
    var move: Int = 0
    var timer = Timer()
    var timerInterval = 1.0
    var timeElapsed:TimeInterval = 1.0
    
    var moveTime: Float = 0.0
    var maxTime: Float = UserDefaults.standard.object(forKey: "myGoalTime") as? Float ?? 0
    //var maxTime: Float = 60.0
    var limitTime: Int = UserDefaults.standard.object(forKey: "myGoalTime") as? Int ?? 0
    var nowKmeter: Double = 0.0
    var get5secKm: Double = 0.0
    var myMeter: Double = 0.0
    var levelStruct = ["초급","중급","고급"]
    var profileImageStruct = ["iconRedmanShorthair","iconBluemanShorthair","iconRedmanBasichair","iconBluemanPermhair","iconRedwomenPonytail","iconBluewomenPonytail","iconRedwomenShortmhair","iconBluewomenPermhair","iconRedwomenBunnowMeterhair"]
    var formatter = DateFormatter()
    
    @IBOutlet weak var lockButton: UIButton!
    
    
    @IBOutlet weak var runPlaceCollectionView: UICollectionView!
    
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var finishTimeLabel: UILabel!
    
    @IBOutlet weak var runProgressBar: UIProgressView!
    
    @IBOutlet weak var runningInfoView: UIView!
    
    @IBOutlet weak var kmLabel: UILabel!
    @IBOutlet weak var opponentKmLabel: UILabel!
    
    
    @IBOutlet weak var leftTimeLabel: UILabel!
    @IBOutlet weak var opponentLeftTimeLabel: UILabel!
    
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var opponentPaceLabel: UILabel!
    
    @IBOutlet weak var voiceLabel: UILabel!
    @IBOutlet weak var voiceOnButton: UIButton!
    @IBOutlet weak var voiceOffButton: UIButton!
    
    @IBOutlet weak var runningStopButton: UIButton!
    
    @IBOutlet var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var naverView: UIView!
    
    @IBAction func lockButtonDidTap(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.runPlaceCollectionView.moveItem(at: [0,0], to: [0,1])
        }
        let tmp = self.runPlace[0]
        self.runPlace[0] = self.runPlace[1]
        self.runPlace[1] = tmp
        self.runPlaceCollectionView.reloadData()
        
        //        if self.view.isUserInteractionEnabled == false {
        //            self.view.isUserInteractionEnabled = true
        //        } else {
        //            self.view.isUserInteractionEnabled = false
        //        }
    }
    
    @IBAction func stopButtonDidTap(_ sender: Any) {
        // 러닝 경쟁 중단하기 버튼 클릭 시 이벤트
        
    
    }
    
    
    override func viewDidLoad() {
        secToTime(sec: limitTime)
        startTimer()
        pedometer.startUpdates(from: Date(), withHandler: { (pedometerData, error) in
            if let pedData = pedometerData{
                self.numberOfSteps = Int(pedData.numberOfSteps)
                //self.stepsLabel.text = "Steps:\(pedData.numberOfSteps)"
                if let distance = pedData.distance{
                    self.distance = Double(distance)
                }
                if let averageActivePace = pedData.averageActivePace {
                    self.averagePace = Double(averageActivePace)
                }
                if let currentPace = pedData.currentPace {
                    self.pace = Double(currentPace)
                }
            } else {
                self.numberOfSteps = nil
            }
        })
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        UserDefaults.standard.set(formatter.string(from: Date()), forKey: "createdTime")
        perform(#selector(runProgressbar), with: nil, afterDelay: 1.0)
        super.viewDidLoad()
        setMap()
        setView()
        setPlace()
        setLabel()
        runPlaceCollectionView.dataSource = self
        runPlaceCollectionView.delegate = self
    }
}



extension RunActivityVC {
    func startTimer(){
        if timer.isValid { timer.invalidate() }
        timer = Timer.scheduledTimer(timeInterval: timerInterval,target: self,selector: #selector(timerAction(timer:)) ,userInfo: nil,repeats: true)
    }
    @objc func timerAction(timer:Timer){
        displayPedometerData()
    }
    func displayPedometerData(){
        
        if let distance = self.distance {
            opponentKmLabel.text = String(format:"%02.02f",distance/1000)
            let pace1 = Int(moveTime/Float(distance/1000))
            let pace2 = Int(pace1/60)
            let pace3 = Int(pace1%60)
            
            if pace2 >= 60 {
                opponentPaceLabel.text = "_'__''"
            } else {
                opponentPaceLabel.text = String(pace2) + "'" + String(pace3) + "''"
            }
        }
    }
    func setPlace() {
        let users: [Information] = CoreDataManager.shared.getUsers()
        let opponents: [Opponent] = CoreDataManager.shared.getOpponent()
        
        runPlace.append(contentsOf : [
            RunPlace(rank: 1,profile: (users.map({Int(($0.image))})[0]), nick: (users.map({($0.nickname ?? "")})[0]), level: (users.map({Int(($0.level))})[0]), win: (users.map({Int(($0.win))})[0]), lose: (users.map({Int(($0.lose))})[0])),
            RunPlace(rank: 2, profile: (opponents.map({Int(($0.profileImage))})[0]), nick: (opponents.map({String(($0.nickname ?? ""))})[0]), level: (opponents.map({Int(($0.level))})[0]), win: (opponents.map({Int(($0.win))})[0]), lose: (opponents.map({Int(($0.lose))})[0]))
        ])
    }
    
    
    func miles(meters:Double)-> Double{
        let mile = 0.000621371192
        return meters * mile
    }
    
    func setLabel() {
        startTimeLabel.text = "00:00"
        startTimeLabel.font = UIFont(name: "NanumSquareB", size: 14)
        
        if maxTime == 1800.0 {
            finishTimeLabel.text = "30:00"
        } else if maxTime == 2700.0 {
            finishTimeLabel.text = "40:00"
        } else if maxTime == 3600.0 {
            finishTimeLabel.text = "1:00:00"
        } else if maxTime == 5400.0 {
            finishTimeLabel.text = "1:30:00"
        } else {
            finishTimeLabel.text = "00:30"
        }
        
        finishTimeLabel.font = UIFont(name: "NanumSquareB", size: 14)
        
        kmLabel.text = "킬로미터"
        kmLabel.font = UIFont(name: "NanumSquareB", size: 14)
        
        leftTimeLabel.text = "남은시간"
        leftTimeLabel.font = UIFont(name: "NanumSquareB", size: 14)
        
        paceLabel.text = "페이스"
        paceLabel.font = UIFont(name: "NanumSquareB", size: 16)
        
        opponentKmLabel.text = "0.00"
        opponentKmLabel.font = UIFont(name: "AvenirNext-BoldItalic", size: 70)
        
        opponentLeftTimeLabel.font = UIFont(name: "AvenirNext-BoldItalic", size: 70)
        
        opponentPaceLabel.text = "_'__''"
        opponentPaceLabel.font = UIFont(name: "AvenirNext-BoldItalic", size: 36)
        
    }
    
    func setView() {
        
        lockButton.setBackgroundImage(UIImage(named: "iconUnlock"), for: .normal)
        lockButton.setTitle(nil, for: .normal)
        
        runningInfoView.backgroundColor = UIColor.salmon
        runningInfoView.layer.cornerRadius = 12
        
        voiceLabel.text = "음성 피드백"
        voiceLabel.font = UIFont(name: "NanumSquareB", size: 18)
        
        voiceOnButton.setTitle("ON", for: .normal)
        voiceOnButton.backgroundColor = UIColor.lightishBlue
        voiceOnButton.setTitleColor(.white, for: .normal)
        voiceOnButton.titleLabel?.font = UIFont(name: "NanumSquareB", size: 14)
        voiceOnButton.layer.cornerRadius = 8
        
        voiceOffButton.setTitle("OFF", for: .normal)
        voiceOffButton.backgroundColor = UIColor.brownishGrey
        voiceOffButton.setTitleColor(.white, for: .normal)
        voiceOffButton.titleLabel?.font = UIFont(name: "NanumSquareB", size: 14)
        voiceOffButton.layer.cornerRadius = 8
        
        runningStopButton.setTitle("러닝 경쟁 중단하기", for: .normal)
        runningStopButton.backgroundColor = UIColor.brownishGrey
        runningStopButton.setTitleColor(.white, for: .normal)
        runningStopButton.titleLabel?.font = UIFont(name: "NanumSquareB", size: 16)
        runningStopButton.layer.cornerRadius = 8
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(updateRunning), userInfo: nil, repeats: true)
    }
    
    @objc func runProgressbar() {
        if moveTime < maxTime {
            moveTime = moveTime + 1.0
            runProgressBar.progress = moveTime/maxTime
            perform(#selector(runProgressbar), with: nil, afterDelay: 1.0)
        } else {
            moveTime = 0.0
            if distance == nil {
                move = 1
            } else {
                move = Int(distance)
            }
            UserDefaults.standard.set(move, forKey: "opponetDistance")
        }
    }
    
    func secToTime(sec: Int){
        let hour = sec / 3600
        let minute = (sec % 3600) / 60
        let second = (sec % 3600) % 60
        if hour == 0 {
            opponentLeftTimeLabel.text = String(minute) + ":" + String(second)
        } else if minute == 0 {
            opponentLeftTimeLabel.text = String(second)
        } else {
            opponentLeftTimeLabel.text = String(hour) + ":" + String(minute) + ":" + String(second)
        }
        if moveTime < maxTime {
            perform(#selector(getSetTime), with: nil, afterDelay: 1.0)
        }
    }
    
    @objc func getSetTime() {
        if moveTime < maxTime {
            secToTime(sec: limitTime)
            limitTime = limitTime - 1
        } else {
            opponentLeftTimeLabel.text = "00:00"
        }
        
    }
    
    @objc func setMap() {
        // 네이버 지도
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        let coor = locationManager.location?.coordinate
        let latiutd = (coor?.latitude) ?? 0.00
        let longitud = (coor?.longitude) ?? 0.00
        
        let mapView = NMFMapView(frame: naverView.bounds)
        naverView.addSubview(mapView)
        mapView.positionMode = .direction
        
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: latiutd, lng: longitud))
        cameraUpdate.animation = .easeIn
        cameraUpdate.animationDuration = 1
        mapView.moveCamera(cameraUpdate)
        
    }
    
    
    
    @objc func updateRunning() {
        let users: [Information] = CoreDataManager.shared.getUsers()
        let usersToken: [String] = users.map({($0.accessToken ?? "")})
        RunningService.shared.runningUpdateRequest(distance: Int(distance ?? 0), time: Int(moveTime), jwt: usersToken[0]) {
            networkResult in switch
                networkResult {
            
            case .success:
                print("running update success")
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
    @objc func getRanking() {
        let users: [Information] = CoreDataManager.shared.getUsers()
        let usersToken: [String] = users.map({($0.accessToken ?? "")})
        RunningService.shared.getRunningRanking(jwt: usersToken[0]) {
            networkResult in switch
                networkResult {
            case .success(let data):
                guard let loadData = data as? UuidData<RunningRankingData> else {return}
                self.rank = loadData
                if let my = self.rank?.data?.ranking {
                    self.myRank = my
                }
                if self.myRank == 1 && self.runPlace[1].nick == (users.map({($0.nickname ?? "")})[0]) {
                    // 내가 2위였는데 1위로 바꿔야 할 때
                    self.runPlaceCollectionView.moveItem(at: [0,1], to: [0,0])
                } else if self.myRank == 2 && self.runPlace[0].nick == (users.map({($0.nickname ?? "")})[0]) {
                    // 내가 1위였는데 2위로 바꿔야 할 때
                    self.runPlaceCollectionView.moveItem(at: [0,0], to: [0,1])
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
    
    
}

extension RunActivityVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return runPlace.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RunPlaceCell.identifier, for: indexPath) as? RunPlaceCell else {
            
            return UICollectionViewCell()
            
        }

        if indexPath.row == 0 {
            cell.placeImage.image =  UIImage(named: "iconRunWin")
        } else {
            cell.placeImage.image = UIImage(named: "iconRunLose")
        }
        cell.setCell(runPlace: runPlace[indexPath.row])
        
        return cell
    }
    
    
}
extension RunActivityVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 17*2, height: 64/341 * (collectionView.frame.width - 17*2))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 17 }
}
