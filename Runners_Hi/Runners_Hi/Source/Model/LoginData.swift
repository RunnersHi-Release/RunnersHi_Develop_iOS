//
//  LoginData.swift
//  Runners_Hi
//
//  Created by 최영재 on 2020/07/11.
//  Copyright © 2020 김민희. All rights reserved.
//

struct LoginData<T: Codable>: Codable {
    var status: Int
    var success: Bool
    var message: String
    var result: [T]?
    
//    enum CodingKeys: String, CodingKey {
//        case status = "status"
//        case success = "success"
//        case message = "message"
//        case result = "result"
//    }
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        status = (try? values.decode(Int.self, forKey: .status)) ?? -1
//        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
//        message = (try? values.decode(String.self, forKey: .message)) ?? ""
//        result = (try? values.decode(Int.self, forKey: .result)) ?? nil
//    }
}
struct TokenData: Codable {
    var token: String
}

struct Uuid: Codable {
    let accessToken, nickname: String
    let gender, image: Int
    let badge: String
    let win, lose: Int
}
