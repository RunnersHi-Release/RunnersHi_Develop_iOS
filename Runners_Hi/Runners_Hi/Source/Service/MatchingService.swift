//
//  MatchingService.swift
//  Runners_Hi
//
//  Created by 김민희 on 2020/09/25.
//  Copyright © 2020 김민희. All rights reserved.
//

import Foundation
import Alamofire

struct MatchingService {
    static let shared = MatchingService()
    private func makeParameter(_ time: Int,_ wantGender: Int) -> Parameters {
        return ["time" : time, "wantGender" : wantGender]
        // 달릴 시간과 원하는 상대방 성별 전달
    }
    
    func startMatchingRequest(time: Int,wantGender: Int, jwt: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let header: HTTPHeaders = ["Content-Type": "application/json", "jwt" : jwt]
        let dataRequest = Alamofire.request(APIConstants.matchingStartURL, method: .post, parameters: makeParameter(time, wantGender), encoding: JSONEncoding.default, headers: header)

        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success :
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.result.value else { return }
                let networkResult = self.judge(by: statusCode, value)
                completion(networkResult)
            case .failure: completion(.networkFail)

            }

        }
    }
    private func judge(by statusCode: Int, _ result: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return isUuid(by: result)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    private func isUuid(by result: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(DuplicateData.self, from: result) else { return .pathErr }
        return .success(decodedData.success)
    }
    
    func findRunnerReq(jwt: String, completion: @escaping (NetworkResult<Any>)->Void) {
        let URL = APIConstants.findRunnerURL
        let headers: HTTPHeaders = ["Content-Type" : "application/json", "jwt" : jwt]
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseData { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    if let status = response.response?.statusCode {
                        switch status {
                        case 200:
                            //상대 러너와 매칭 성공시
                            do {
                                let decoder = JSONDecoder()
                                let result = try decoder.decode(DuplicateData.self, from: value)
                                completion(.success(result.status))
                            } catch {
                                completion(.pathErr)
                            }
                        case 204:
                            // 매칭 대기 (30초 기다리면 온다)
                            do {
                                let decoder = JSONDecoder()
                                let result = try decoder.decode(DuplicateData.self, from: value)
                                completion(.success(result.status))
                            } catch {
                                completion(.pathErr)
                            }
                        default:break
                        }
                    }
                }
            case .failure:
                //대기열에 해당 사용자가 없을 때
                completion(.networkFail)
                
            }
        }
    }
    func stopMatchingReq(jwt: String, completion: @escaping (NetworkResult<Any>)->Void) {
        let URL = APIConstants.findRunnerURL
        let headers: HTTPHeaders = ["Content-Type" : "application/json", "jwt" : jwt]
        Alamofire.request(URL, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseData { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    if let status = response.response?.statusCode {
                        switch status {
                        case 200:
                            do {
                                let decoder = JSONDecoder()
                                let result = try decoder.decode(DuplicateData.self, from: value)
                                print(result.message)
                                completion(.success(result.success))
                                // 매칭 중단 성공
                            } catch {
                                completion(.pathErr)
                            }
                        default:break
                        }
                    }
                }
            case .failure:
                //대기열에 해당 사용자가 없을 때
                completion(.networkFail)
                
            }
        }
    }
}
