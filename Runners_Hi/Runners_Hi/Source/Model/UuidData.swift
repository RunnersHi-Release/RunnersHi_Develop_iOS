//
//  UuidData.swift
//  Runners_Hi
//
//  Created by 김민희 on 2020/09/24.
//  Copyright © 2020 김민희. All rights reserved.
//

import Foundation

struct UuidData: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: UuidDetail?
}

struct UuidDetail: Codable {
    let accessToken, nickname: String
    let gender, image: Int
    let badge: String
    let win, lose: Int
}
