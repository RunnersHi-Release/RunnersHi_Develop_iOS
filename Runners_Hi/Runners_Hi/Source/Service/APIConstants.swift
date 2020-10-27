//
//  APIConstants.swift
//  Runners_Hi
//
//  Created by 김민희 on 2020/07/10.
//  Copyright © 2020 김민희. All rights reserved.
//

import Foundation
struct APIConstants {
    static let baseURL = "http://3.34.213.235"
    static let signupURL = APIConstants.baseURL + "/user/register"
    static let duplicateURL = APIConstants.baseURL + "/user/duplicates"
    static let loginURL = APIConstants.baseURL + "/user/login"
    //uuid 체크인
    static let uuidURL = APIConstants.baseURL + "/user/signUUID"
    // 매칭 요청
    static let matchingReqURL = APIConstants.baseURL + "/running/match"
    //상대방 러너의 프로필 조회
    static let opponentInfoURL = APIConstants.baseURL + "/running/opponentInfo"
    //나의 모든 기록 조회
    static let myrecordURL = APIConstants.baseURL + "/record/all"
    //뱃지 모아보기
    static let badgeURL = APIConstants.baseURL + "/record/badge"
    //이 달의 러너
    static let monthlyURL = APIConstants.baseURL + "/ranking/runners"
    //명예의 전당
    static let winnerURL = APIConstants.baseURL + "/ranking/winners"
    //졌잘싸
    static let loserURL = APIConstants.baseURL + "/ranking/losers"
    static let opponentURL = APIConstants.baseURL + "/record/opponent/"
    static let recentURL = APIConstants.baseURL + "/record/recent"
    //마이페이지
    static let myprofileURL = APIConstants.baseURL + "/user/myProfile"
    static let badgedatilURL = APIConstants.baseURL + "/record/badge/detail/"
    
    

    
}
