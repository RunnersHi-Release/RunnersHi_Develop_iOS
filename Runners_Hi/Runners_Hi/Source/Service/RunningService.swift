//
//  RunningService.swift
//  Runners_Hi
//
//  Created by 김민희 on 2020/11/28.
//  Copyright © 2020 김민희. All rights reserved.
//

import Foundation
import Alamofire

struct RunningService {
    static let shared = RunningService()
    
    private func updateParameter(_ distance: Int,_ time: Int) -> Parameters {
        return ["distance": distance, "time": time]
        // 지금까지 달린거리(m), 지금까지 달린시간(초) 전달
    }
    
    func runningUpdateRequest(distance: Int, time: Int, jwt: String, completion: @escaping (NetworkResult<Any>)->Void) {
        
        let URL = APIConstants.runningUpdateURL + "\(UserDefaults.standard.integer(forKey: "runIdx"))"
        let headers: HTTPHeaders = ["Content-Type" : "application/json", "jwt" : jwt]
        
        Alamofire.request(URL, method: .put, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseData { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    if let status = response.response?.statusCode {
                        switch status {
                        case 200:
                            do {
                                let decoder = JSONDecoder()
                                let result = try decoder.decode(DuplicateData.self, from: value)
                                completion(.success(result))
                                // 러닝 업데이트 성공
                            } catch {
                                completion(.pathErr)
                            }
                        default:break
                        }
                    }
                }
            case .failure:
                completion(.networkFail)
                
            }
        }
    }

}
