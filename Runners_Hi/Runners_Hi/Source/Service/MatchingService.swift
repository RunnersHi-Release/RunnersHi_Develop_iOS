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
    }
    func matchingRequest(time: Int,wantGender: Int, jwt: String, completion: @escaping (NetworkResult<Any>) -> Void) {

        let header: HTTPHeaders = ["Content-Type": "application/json", "jwt" : jwt]
        let dataRequest = Alamofire.request(APIConstants.matchingReqURL, method: .post, parameters: makeParameter(time, wantGender), encoding: JSONEncoding.default, headers: header)

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
        guard let decodedData = try? decoder.decode(UuidData<MatchingRequest>.self, from: result) else { return .pathErr }
        return .success(decodedData.data.runIdx)
    }
}