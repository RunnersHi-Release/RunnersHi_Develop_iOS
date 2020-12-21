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
        
        Alamofire.request(URL, method: .put, parameters: updateParameter(distance,time), encoding: JSONEncoding.default, headers: headers).responseData { response in
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
    
    func getRunningRanking(jwt: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let header : HTTPHeaders = ["Content-Type": "application/json", "jwt" : jwt]
        let url = APIConstants.runningRankingURL + "\(UserDefaults.standard.integer(forKey: "runIdx"))"
        let dataRequest = Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
        
        dataRequest.responseData { (response) in
            switch response.result {
            
            case .success :
                guard let statusCode = response.response?.statusCode else {
                    return
                }
                guard let data = response.value else {
                    return
                }
                completion(judge(by: statusCode, data))
            case .failure(let err):
                print(err)
            }
            
        }
        
    }
    private func judge(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return ranking(by: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    private func ranking(by data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(UuidData<RunningRankingData>.self, from: data) else { return .pathErr }
        return .success(decodedData)
    }

}
