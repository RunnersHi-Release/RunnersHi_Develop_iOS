//
//  UuidData.swift
//  Runners_Hi
//
//  Created by 김민희 on 2020/09/24.
//  Copyright © 2020 김민희. All rights reserved.
//

import Foundation

struct UuidData<T: Codable>: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: T
}

struct UuidDetail: Codable {
    let accessToken, nickname: String
    let gender, image: Int
    let badge: String
    let win, lose: Int
}

struct MatchingRequest {
    let runIdx: Int
    
    enum CodingKeys: String, CodingKey {
        case runIdx = "run_idx"
    }
}
