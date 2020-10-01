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
    let data: T?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? values.decode(Int.self, forKey: .status)) ?? -1
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(T.self, forKey: .data)) ?? nil
    }
}

struct UuidDetail: Codable {
    let accessToken, nickname: String
    let gender, image, level: Int
    let badge: String
    let win, lose: Int
}

struct MatchingRequest: Codable {
    let runIdx: Int
    
    enum CodingKeys: String, CodingKey {
        case runIdx = "run_idx"
    }
}

struct OpponentInfo: Codable {
    let nickname: String
    let win, lose, image, level: Int
}
